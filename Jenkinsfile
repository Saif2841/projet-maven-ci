pipeline {
    agent any

    tools { 
        maven 'M2_HOME'
    }

    environment {
        DOCKERHUB_USER = "nightcoresifo2841"              // your DockerHub username
        IMAGE_NAME     = "devopspipeline"                 // your repo name
        TAG            = "latest"                         
        DOCKER_CREDENTIALS = "dockerhub-creds"            // Jenkins credentials ID
    }

    stages {
        stage('Checkout Git') {
            steps {
                git branch: 'main', url: 'https://github.com/Rahmed999/Devops.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t ${DOCKERHUB_USER}/${IMAGE_NAME}:${TAG} \
                    -f docker/Dockerfile .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: DOCKER_CREDENTIALS,
                    passwordVariable: 'DOCKER_PASS',
                    usernameVariable: 'DOCKER_USER'
                )]) {
                    script {
                        sh '''
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:${TAG}
                        '''
                    }
                }
            }
        }
    }

    post {
        success { echo 'Pipeline completed successfully!' }
        failure { echo 'Pipeline failed. Check the logs!' }
    }
}
