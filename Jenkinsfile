pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                script {
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
            emailext subject: 'Jenkins success',
                      body: '''this is a Jenkins email alerts linked with GitHub
                      test
                      thank you
                      Azza KOUKA''',
                      to: 'azza.kouka@esprit.tn'
        }
        failure {
            emailext subject: 'Jenkins failure',
                      body: '''this is a Jenkins email alerts linked with GitHub
                      test
                      thank you
                      Azza KOUKA''',
                      to: 'azza.kouka@esprit.tn'
        }
    }
}
