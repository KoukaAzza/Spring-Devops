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

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('COMPILE') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('Install') {
            steps {
                sh 'mvn install'
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
            mail to: 'azza.kouka@esprit.tn',
                 subject: 'Jenkins Notification: Success',
                 body: '''This is a Jenkins email alerts linked with GitHub.
                    Test
                    Thank you
                    Azza KOUKA'''
        }

        failure {
            mail to: 'azza.kouka@esprit.tn',
                 subject: 'Jenkins Notification: Failure',
                 body: '''This is a Jenkins email alerts linked with GitHub.
                    Test
                    Thank you
                    Azza KOUKA'''
        }
    }
}


