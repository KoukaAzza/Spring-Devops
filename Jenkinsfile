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

        stage("SonarQube analysis") {
            steps {
                 withSonarQubeEnv('sonarQube') {
                sh 'mvn sonar:sonar'
              } 
            }
            post {
                success {
                    emailext(
                        subject: "Success: SonarQube Analysis Completed",
                        body: "SonarQube analysis was successful.",
                        to: "azza.kouka@esprit.tn"
                    )
                }
                failure {
                    emailext(
                        subject: "Failure: SonarQube Analysis Failed",
                        body: "SonarQube analysis has failed.",
                        to: "azza.kouka@esprit.tn"
                    )
                }
            }
        }
    }
}







