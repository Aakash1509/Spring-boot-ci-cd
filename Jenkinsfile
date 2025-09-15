pipeline {
    agent any

    environment {
        IMAGE_NAME = "todo-app"
        CONTAINER_NAME = "todo-app-container"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Aakash1509/Spring-boot-ci-cd'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Stop and Remove Old Container') {
            steps {
                sh '''
                if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ]; then
                    docker stop ${CONTAINER_NAME} && docker rm ${CONTAINER_NAME}
                fi
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh "docker run -d --name ${CONTAINER_NAME} -p 8081:8080 ${IMAGE_NAME}"
            }
        }
    }

    post {
        success {
            echo 'Build and deployment successful!'
        }
        failure {
            echo 'Build failed.'
        }
    }
}
