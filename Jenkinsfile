pipeline{
    agent{
        label "jenkins-agent"
    }
    tools{
        maven "Maven3"
        jdk "Java17"
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
        stage{
            step{
                script{
                waitForQualityGate abortPipeline: False, credentialsId: 'sonarqube-token'
                }
            }
        }
    }
}