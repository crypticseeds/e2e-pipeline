FROM maven:3.9.0-eclipse-temurin-17 as build
WORKDIR /app
COPY . .
RUN mvn clean install

FROM eclipse-temurin:17.0.6_10-jdk
WORKDIR /app
COPY --from=build /app/target/demoapp.jar /app/
EXPOSE 8080
CMD ["java", "-jar","demoapp.jar"]






    environment{
        APP_NAME = "e2e-pipeline"
        RELEASE = "1.0.0"
        DOCKER_USER = "crypticseeds"
        DOCKER_PASS = "dockerhub-token"
        IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }


        stage('Docker Build and Push image'){
            steps{
                script{
                    docker.withDockerRegistry('',DOCKER_PASS){
                        docker_image = docker.build("${IMAGE_NAME}")
                    }
                    docker.withDockerRegistry('',DOCKER_){
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push("latest")
                    }

                }
            }
        }