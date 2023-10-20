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
                        userRemoteConfigs: [[url: 'https://github.com/KoukaAzza/DevOps-Spring.git']]
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

        stage("Test") {
            steps {
                sh 'mvn test'  // This runs your Spring Boot application tests using Maven
            }
        }

        stage("SonarQube analysis") {
            agent any
            steps {
                withSonarQubeEnv('sonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
    } 
    post {
        success {
            emailext subject: 'Jenkins Pipeline Successful',
                      body: 'Your Jenkins pipeline has successfully completed.',
                      to: 'azza.kouka@esprit.tn'
        }
        failure {
            emailext subject: 'Jenkins Pipeline Failed',
                      body: 'Your Jenkins pipeline has failed. Please check the build logs for details.',
                      to: 'azza.kouka@esprit.tn'
        }
    }
}
