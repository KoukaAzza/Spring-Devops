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
                      to: 'azzakouka50@gmail.com'
        }
        failure {
            emailext subject: 'Jenkins failure',
                      body: '''this is a Jenkins email alerts linked with GitHub
                      test
                      thank you
                      Azza KOUKA''',
                      to: 'azzakouka50@gmail.com'
        }
    }
}
