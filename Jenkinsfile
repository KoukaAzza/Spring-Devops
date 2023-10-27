pipeline {
    agent any
    stages {
        stage('Set Java Version') {
            steps {
                script {
                    tool name: 'JAVA_HOME', type: 'jdk'
                }
            }
        }
        stage('Checkout Backend Repo') {
            steps {
                script {
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/master']],
                        userRemoteConfigs: [[url: 'https://github.com/KoukaAzza/Spring-Devops']]
                    ])
                }
            }
        }
        // stage('BUILD Backend') {
        //     steps {
        //         withEnv(["JAVA_HOME=${tool name: 'JAVA_HOME', type: 'jdk'}"]) {
        //             sh 'mvn clean package'
        //         }
        //     }
        // }
        stage('COMPILE Backend') {
            steps {
                sh 'mvn compile'
            }
        }
        // stage("SonarQube Analysis") {
        //     steps {
        //         tool name: 'JAVA_HOME', type: 'jdk'
        //         withEnv(["JAVA_HOME=${tool name: 'JAVA_HOME', type: 'jdk'}"]) {
        //             withSonarQubeEnv('sonarQube') {
        //                 script {
        //                     def scannerHome = tool 'SonarQubeScanner'
        //                     withEnv(["PATH+SCANNER=${scannerHome}/bin"]) {
        //                         sh 'mvn sonar:sonar -Dsonar.java.binaries=target/classes'
        //                     }
        //                 }
        //             }
        //         }
        //     }
        // }
        // stage('Checkout Frontend Repo') {
        //     steps {
        //         script {
        //             checkout([
        //                 $class: 'GitSCM',
        //                 branches: [[name: 'master']],
        //                 userRemoteConfigs: [[url: 'https://github.com/KoukaAzza/front-devops.git']]
        //             ])
        //         }
        //     }
        // }

        // stage('Build Frontend') {
        //     steps {
        //         sh 'npm install'
        //         sh 'npm run ng build'
        //     }
        // }
stage('Build and Push back Images') {
            steps {
                script {
                    // Ajoutez l'étape Git checkout pour le référentiel backend ici
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/master']],
                        userRemoteConfigs: [[url: 'https://github.com/KoukaAzza/Spring-Devops']]
                    ])

                    // Build the backend Docker image
                    def backendImage = docker.build('azzakouka/devops:backend', '-f /var/lib/jenkins/workspace/Devops/Dockerfile .')

                    // Authentification Docker Hub avec des informations d'identification secrètes
                    withCredentials([string(credentialsId: 'Docker', variable: 'password')]) {
                        sh "docker login -u azzakouka -p ${password}"
                        // Poussez l'image Docker
                        backendImage.push()
                    }
                }
            }
        }


    }
    post {
        success {
            mail to: 'azza.kouka@esprit.tn',
            subject: 'Jenkins Notification: Success',
            body: '''This is a Jenkins email alerts linked with GitHub.
                Build and push to Docker Hub successful.
                Thank you
                Azza KOUKA'''
        }
        failure {
            mail to: 'azza.kouka@esprit.tn',
            subject: 'Jenkins Notification: Failure',
            body: '''This is a Jenkins email alert linked with GitHub.
                Build or push to Docker Hub failed.
                Thank you
                Azza KOUKA'''
        }
    }
}
