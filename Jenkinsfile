pipeline {
    agent any
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
        stage('Publish to Nexus') {
    steps {
        // Assurez-vous que vous avez configuré les informations de votre serveur Nexus dans Jenkins
        // Cela peut être fait via les paramètres globaux de Jenkins ou un fichier de configuration (settings.xml) dans votre projet Maven.
        
        // Utilisez le plugin Maven Nexus Staging pour publier l'artefact sur le dépôt Nexus
        sh 'mvn clean deploy'
    }

    }
    
    }
}

