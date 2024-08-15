Jenkinsfile
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
                    git branch: 'main', credentialsId: 'GitHub' url: 'https://github.com/crypticseeds/e2e-pipeline.git'
                }
            }
        }
    }