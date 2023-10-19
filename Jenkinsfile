pipeline {
    agent any // Define the agent for the pipeline (e.g., any available agent)

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout your source code from the repository.
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/master']], // You can specify the branch you want to build here.
                        userRemoteConfigs: [[url: 'https://github.com/KoukaAzza/DevOps-Spring.git']]
                    ])
                }
            }
        }

       // stage('Clean') {
         //   steps {
                // Run 'mvn clean' to clean the project
           //     sh 'mvn clean'
            //}
        //}

        stage('Install') {
            steps {
                // Run 'mvn install' to build and install the project
                sh 'mvn install'
            }
        }

        // Add more stages for additional build, test, or deployment steps
    }
}
    


      
