pipeline{
    agent{
        label "jenkins-agent"
    }
    tools{
        maven "Maven3"
        jdk "Java17"
    }
    environment{
        APP_NAME = "e2e-pipeline"
        RELEASE = "1.0.0"
        DOCKER_USER = "crypticseeds"
        DOCKER_PASS = credentials"dockerhub-token"
        IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }
    stages{
        stage('Clean up workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout from SCM'){
            steps{
                git branch: 'main', credentialsId: 'GitHub', url: 'https://github.com/crypticseeds/e2e-pipeline.git'
            }
        }
        stage('Build application'){
            steps{
                sh "mvn clean package"
            }
        }
        stage( 'Test application'){
            steps{
                sh "mvn test"
            }
        }
        stage('Sonaqube analysis'){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonarqube-token'){
                    sh "mvn sonar:sonar"
                    }
                }
            }
        }
        stage( 'Quality Gate'){
            steps{
                script{
                waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube-token'
                }
            }
        }
        stage('Docker Build and Push image'){
            steps{
                script{
                    docker.withRegistry('',DOCKER_PASS){
                        def docker_image = docker.build("${IMAGE_NAME}")
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push("latest")
                    }

                }
            }
        }
    }
}