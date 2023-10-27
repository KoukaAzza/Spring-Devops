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
// stage('Build and Push Backend Image') {
//     steps {
//         script {
//             // Add the Git checkout step for the backend repository here
//             checkout([
//                 $class: 'GitSCM',
//                 branches: [[name: '*/master']],
//                 userRemoteConfigs: [[url: 'https://github.com/KoukaAzza/Spring-Devops']]
//             ])
            
//             // Authenticate with Docker Hub using credentials
//             withCredentials([string(credentialsId: 'Docker', variable: 'password')]) {
//                 sh "docker login -u azzakouka -p azzaesprit159"
//             }
            
//             // Build the backend Docker image
//             def backendImage = docker.build('azzakouka/devops', '-f /var/lib/jenkins/workspace/Devops/Dockerfile .')
            
//             // Push the Docker image
//             backendImage.push()
//         }
//     }
// }

        stage('Build and Push Frontend Image') {
    steps {
        script {
            // Add the Git checkout step for the backend repository here
            checkout([
                $class: 'GitSCM',
                branches: [[name: '*/master']],
                userRemoteConfigs: [[url: 'https://github.com/KoukaAzza/front-devops']]
            ])
            
            // Authenticate with Docker Hub using credentials
            withCredentials([string(credentialsId: 'Docker', variable: 'password')]) {
                sh "docker login -u azzakouka -p azzaesprit159"
            }
            
            // Build the backend Docker image
            def backendImage = docker.build('azzakouka/devops:frontend', '-f Dockerfile .')
            
            // Push the Docker image
            backendImage.push()
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
