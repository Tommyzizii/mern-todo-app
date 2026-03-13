pipeline {

    agent any

    environment {
        DOCKER_HUB_USER = 'tommyzizii'
        IMAGE_NAME = 'finead-todo-app'
        DOCKER_HUB_CREDS = 'docker-hub-credentials'
    }

    stages {

        stage('Build') {
            agent {
                docker {
                    image 'node:22'
                    args '-u root'
                }
            }

            steps {
                sh '''
                cd TODO/todo_backend
                npm install

                cd ../todo_frontend
                npm install
                npm run build

                rm -rf ../todo_backend/static/build
                mv build ../todo_backend/static
                '''
            }
        }

        stage('Containerise') {
            steps {
                sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push') {

            steps {

                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_HUB_CREDS}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
                }

            }

        }

    }

}