pipeline {
    agent any
    stages {
        stage('Set Java Version') {
            steps {
                script {
                    // Set the default JAVA_HOME to Java 8
                    tool name: 'JAVA_HOME', type: 'jdk'
                }
            }
        }
        stage('Checkout Backend Repo') {
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
        stage('BUILD Backend') {
            steps {
                // Use Java 8 for this stage
                withEnv(["JAVA_HOME=${tool name: 'JAVA_HOME', type: 'jdk'}"]) {
                    sh 'mvn clean package'
                }
            }
        }
        stage('COMPILE Backend') {
            steps {
                // Use the default Java 8 for this stage
                sh 'mvn compile'
            }
        }
        stage("SonarQube Analysis") {
            steps {
                // Set Java 11 for this stage
                tool name: 'JAVA_HOME', type: 'jdk'
                withEnv(["JAVAA_HOME=${tool name: 'JAVAA_HOME', type: 'jdk'}"]) {
                    withSonarQubeEnv('sonarQube') {
                        script {
                            def scannerHome = tool 'SonarQubeScanner'
                            withEnv(["PATH+SCANNER=${scannerHome}/bin"]) {
                                sh '''
                                    mvn sonar:sonar \
                                        -Dsonar.java.binaries=target/classes
                                '''
                            }
                        }
                    }
                }
            }
        }
        stage('Checkout Frontend Repo') {
            steps {
                script {
                    // Checkout the frontend repository
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
                // Add steps to build your Angular frontend application here
                // For example:
                sh 'npm install'
                sh 'ng build'
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

