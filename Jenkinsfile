pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile
                    docker.build('my-codeserver-image', '-f Dockerfile .')
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container from the built image on port 8081
                    docker.image('my-codeserver-image').withRun('-p 8081:8081')
                }
            }
        }
    }

    post {
        always {
            // Clean up by stopping and removing the Docker container
            script {
                docker.image('my-codeserver-image').stop()
                docker.image('my-codeserver-image').remove(force: true)
            }
        }
    }
}
