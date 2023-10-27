pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-credentials')
        BACKEND_IMAGE = 'azzakouka/devops-backend:latest'
    }
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
        stage('BUILD Backend') {
            steps {
                withEnv(["JAVA_HOME=${tool name: 'JAVA_HOME', type: 'jdk'}"]) {
                    sh 'mvn clean package'
                }
            }
        }
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
        stage('Checkout Frontend Repo') {
            steps {
                script {
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: 'master']],
                        userRemoteConfigs: [[url: 'https://github.com/KoukaAzza/front-devops.git']]
                    ])
                }
            }
        }

        stage('Build Frontend') {
            steps {
                sh 'npm install'
                sh 'npm run ng build'
            }
        }
 stage('Build and Push Docker Image') {
    steps {
        script {
            // Add the Git checkout step for the backend repository here
            checkout([
                $class: 'GitSCM',
                branches: [[name: '*/master']],
                userRemoteConfigs: [[url: 'https://github.com/KoukaAzza/Spring-Devops']]
            ])
           
            // Build and push the backend Docker image
            def backendImage = docker.build(BACKEND_IMAGE, '-f /var/lib/jenkins/workspace/Devops/Dockerfile .')
             withCredentials([string(credentialsId: 'Docker', variable: 'password')]){
                sh "docker login -u azzakouka -p ${password}"
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
