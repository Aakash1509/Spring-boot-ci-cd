pipeline {
    agent any

    parameters {
        string(name: 'IMAGE_NAME', defaultValue: 'todo-app', description: 'Docker image name')
        string(name: 'CONTAINER_NAME', defaultValue: 'todo-app-container', description: 'Docker container name')
        string(name: 'APP_PORT', defaultValue: '8081', description: 'Host port to expose the app')
    }

    environment {
        IMAGE_NAME = "${params.IMAGE_NAME}"
        CONTAINER_NAME = "${params.CONTAINER_NAME}"
        APP_PORT = "${params.APP_PORT}"
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
                sh "docker run -d --name ${CONTAINER_NAME} -p ${APP_PORT}:8080 ${IMAGE_NAME}"
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
