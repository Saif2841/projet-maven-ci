pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'nightcoresifo2841'    // <-- your Docker Hub username
        IMAGE_NAME     = 'projet-maven-ci'      // image name
    }

    // For now: poll SCM every minute (easy to test)
    triggers {
        pollSCM('* * * * *')   // every minute
        // When your webhook is OK, you can remove this and use "GitHub hook trigger" in the job config.
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Saif2841/projet-maven-ci.git'
            }
        }

        stage('Build Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker image') {
            steps {
                sh '''
                    docker build \
                      -t "$DOCKERHUB_USER/$IMAGE_NAME:$BUILD_NUMBER" \
                      .
                '''
            }
        }

        stage('Push Docker image') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'DOCKERHUB_TOKEN')]) {
                    sh '''
                        echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USER" --password-stdin
                        docker push "$DOCKERHUB_USER/$IMAGE_NAME:$BUILD_NUMBER"
                        docker tag "$DOCKERHUB_USER/$IMAGE_NAME:$BUILD_NUMBER" "$DOCKERHUB_USER/$IMAGE_NAME:latest"
                        docker push "$DOCKERHUB_USER/$IMAGE_NAME:latest"
                    '''
                }
            }
        }
    }
}
