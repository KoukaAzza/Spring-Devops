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
            agent any
            steps {
              withSonarQubeEnv('sonarQube') {
                sh 'mvn sonar:sonar'
              }
            }
          }
         /*stage('Email notification') {
            steps {
                mail bcc: '', body: '''this is a Jenkins email alerts linked with GitHub 
                    test
                    thank you
                    Azza KOUKA''', cc: '', from: '', replyTo: '', subject: 'Jenkins notification', to: 'azza.kouka@esprit.tn'
            }
        }*/
    
        //Add more stages
} 
}
