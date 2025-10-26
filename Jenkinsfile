pipeline {
    agent any

    environment {
        // Define the name and tag for your Docker image
        DOCKER_IMAGE = "my-app-image:${env.BUILD_ID}"
        CONTAINER_NAME = "my-app-container"
    }

    stages {
        // 1. Checkout Code
        stage('Checkout') {
            steps {
                echo 'Cloning the application repository...'
                // You would use the 'git' step here for a real repo
                // Example: git url: 'https://github.com/your-username/your-app.git', branch: 'main'
            }
        }

        // 2. Build Docker Image
        stage('Build') {
            steps {
                echo 'Building Docker image...'
                // This command assumes a Dockerfile exists in the root of the repo
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        // 3. Test/Verify (using the newly built image)
        stage('Test') {
            steps {
                echo 'Running tests...'
                // Placeholder for running unit/integration tests inside a container
                sh 'echo "Tests passed successfully!"' 
                // In a real scenario, this would involve running a container with specific test commands.
            }
        }

        // 4. Deploy Application
        stage('Deploy') {
            steps {
                echo 'Deploying application by stopping old and starting new container...'
                
                // Stop and remove the old container to ensure a clean deployment
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"

                // Run the new container, exposing port 80 on the host (EC2)
                // You must ensure this port is open in your AWS Security Group.
                sh "docker run -d --name ${CONTAINER_NAME} -p 80:8080 ${DOCKER_IMAGE}"
            }
        }
    }
    
    post {
        always {
            echo "Pipeline finished with status: ${currentBuild.result}"
        }
    }
}
