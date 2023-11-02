pipeline {
    agent any
      tools {
      maven "Maven3"
   }
  environment {
     NEXUS_VERSION= "http"
     NEXUS_URL= "http://192.168.33.10:8081"
     NEXUS_REPOSITORY = "maven-releases"
     NEXUS_CREDENTIAL_ID= "nexus-credentials"
}

    stages {
        stage('Build') {
            steps {
                // Étape pour compiler votre projet
                sh 'mvn clean'  // Exemple avec Apache Maven, adaptez à votre projet
            }
        }    
         stage('Compile') {
            steps {
                // Étape pour compiler votre projet
                sh 'mvn compile'  
            }
        } 
        
         stage ('Code Quality'){
            steps {
                    withSonarQubeEnv('SonarQubeServer') {
                sh 'mvn sonar:sonar'
                }
             }
        }
        stage('JUNIT/MOCKITO') {
                    steps {
                        // Exécute les tests unitaires avec Maven et affiche les rapports
                        sh 'mvn test'
                    }
                    post {
                        always {
                            junit '**/target/surefire-reports/TEST-*.xml'
                        }
                    }
                }
          stage(' Artifact construction') {
            steps {
                // Étape pour construire l'artefact (par exemple, un fichier JAR)
                sh 'mvn package'
            }
            post {
                success {
                    archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
                }
            }
        }
        stage("Publish to Nexus Repository Manager") {
            steps {
                script {
                    pom = readMavenPom file: "pom.xml";
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path;
                    artifactExists = fileExists artifactPath;
                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: pom.version,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging],
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );
                    } else {
                        error "*** File: ${artifactPath}, could not be found";
                    }
                }
            }
  }
   
          
    
    }
}

