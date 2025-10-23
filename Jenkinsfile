// Define the agent to run the entire pipeline (using a label if on a distributed system, or 'any' on a single machine)
// Ensure Docker is accessible from this agent.
pipeline {
    agent any

    // Environment variables that can be used throughout the pipeline
    environment {
        // Define your Docker Hub username or use a local tag
        DOCKER_IMAGE = "my-jenkins-app" // Replace with a meaningful name or use DOCKERHUB_CREDENTIAL_ID
        DOCKER_REGISTRY = "" // Add your registry URL if needed, e.g., "docker.io/yourusername"
    }

    // Stages define the sequential steps of the CI/CD process
    stages {
        // 1. Checkout Stage: Get the source code
        stage('Checkout Code') {
            steps {
                // Check out the code from the Git repository
                // In a configured Jenkins job, this is often handled automatically.
                // For a good practice, you can use:
                git 'YOUR_GIT_REPOSITORY_URL' // Replace with your actual repository URL
            }
        }

        // 2. Build Stage: Build the Docker image
        stage('Build Image') {
            steps {
                echo 'Building Docker Image...'
                // Build the Docker image using the Dockerfile in the root of the repo
                script {
                    // Build with a tag using the current build number
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}", ".")
                }
            }
        }

        // 3. Test Stage: Run unit/integration tests (placeholder in this simple example)
        stage('Test App') {
            steps {
                echo 'Running tests...'
                // You'd typically run commands like 'npm test' or equivalent here.
                sh 'npm test'
            }
        }

        // 4. Deploy Stage: Run the container
        stage('Deploy App') {
            steps {
                echo 'Deploying Docker Container...'
                script {
                    // Stop and remove any previous running container (optional but useful for local testing)
                    sh 'docker stop my-app-container || true'
                    sh 'docker rm my-app-container || true'

                    // Run the newly built container
                    sh "docker run -d --name my-app-container -p 8080:3000 ${DOCKER_IMAGE}:${env.BUILD_NUMBER}"
                }
                echo 'Deployment complete. App is running on port 8080.'
            }
        }
    }

    // Post-build actions (optional)
    post {
        always {
            // Cleanup workspace regardless of the build result
            cleanWs()
        }
        success {
            echo 'Pipeline finished successfully! 🎉'
        }
        failure {
            echo 'Pipeline failed. Check the logs. 🔴'
        }
    }
}