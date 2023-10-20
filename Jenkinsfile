pipeline {
    agent any 
    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout your source code from the repository.
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/master']], 
                       userRemoteConfigs: [[url: 'https://github.com/KoukaAzza/Spring-Devops.git']]
                    ])
                }
            } 
        }

        stage('Clean') {
            steps {
                sh 'mvn clean'
            }
        }

      stage('COMPILE') {
            steps {
                sh 'mvn compile'
            }
        }

         stage('TEST') {
            steps {
                sh 'mvn test'
            }
        }
     /*   stage('Test') {
            steps {
                script {
            // Change directory to your Spring Boot application directory
                dir('https://github.com/KoukaAzza/Spring-Devops/tree/master/src/test') {
                // Use Maven to run tests
                sh 'mvn test'
                // or use Gradle to run tests
                // sh './gradlew test'
            }
        }
    }
}*/
         /*  stage('Email notification') {
            steps {
                mail bcc: '', body: '''this is a Jenkins email alerts linked with GitHub 
                    test
                    thank you
                    Azza KOUKA''', cc: '', from: '', replyTo: '', subject: 'Jenkins notification', to: 'azza.kouka@esprit.tn'
            }
        }*/
         stage("SonarQube analysis") {
            agent any
            steps {
              withSonarQubeEnv('sonarQube') {
                sh 'mvn sonar:sonar'
              } 
            }
          }
        //Add more stages
    }
            post {
                success {
                    emailext(
                         mail bcc: '', body: '''SonarQube analysis has passed. 
                         ''', cc: '', from: '', replyTo: '', subject: 'Success: SonarQube Analysis Success', to: 'azza.kouka@esprit.tn'
                    )
                }
                failure {
                    emailext(
                        mail bcc: '', body: '''SonarQube analysis has failed. 
                         ''', cc: '', from: '', replyTo: '', subject: 'Failure: SonarQube Analysis Failure', to: 'azza.kouka@esprit.tn'
                    )
                }
            }
} 
