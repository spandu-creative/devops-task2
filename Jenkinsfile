pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/spandu-creative/devops-task2.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t myapp:latest .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker ps -q --filter "name=myapp" | grep -q . && docker stop myapp && docker rm myapp || true
                docker run -d -p 5000:5000 --name myapp myapp:latest
                '''
            }
        }
    }
}
