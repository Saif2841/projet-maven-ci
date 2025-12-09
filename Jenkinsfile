pipeline {
    agent any

    tools { 
        maven 'M2_HOME'
    }

    environment {
        DOCKERHUB_USER      = "nightcoresifo2841"      // Docker Hub username
        IMAGE_NAME          = "devopspipeline"         // Docker Hub repository name
        TAG                 = "latest"                 // Docker tag
        DOCKER_CREDENTIALS  = "dockerhub-token"        // Jenkins Secret Text credential ID
    }

    stages {

        stage('Checkout Git') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/Saif2841/projet-maven-ci.git'
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
                    echo "Building Docker image..."
                    docker build -t ${DOCKERHUB_USER}/${IMAGE_NAME}:${TAG} \
                    -f docker/Dockerfile .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([string(
                    credentialsId: DOCKER_CREDENTIALS,
                    variable: 'DOCKER_TOKEN'
                )]) {
                    sh '''
                        echo "Logging into Docker Hub..."
                        echo "$DOCKER_TOKEN" | docker login -u "${DOCKERHUB_USER}" --password-stdin

                        echo "Pushing Docker image..."
                        docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:${TAG}

                        echo "Docker image pushed successfully."
                    '''
                }
            }
        }
    }

    post {
        success { 
            echo '🎉 Pipeline completed successfully!' 
        }
        failure { 
            echo '❌ Pipeline failed. Check the logs!' 
        }
    }
}
