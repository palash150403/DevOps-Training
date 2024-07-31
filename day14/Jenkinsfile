pipeline{

    agent any

    environment{
        dockerImage = ''
        registry = 'palash150403/jenkins_docker_image'
        // registryCredentials = 'Docker'
    }

    stages{
        stage('Build Docker Image'){
            steps{
                script{ 
                    dockerImage = docker.build("${registry}:latest")
                }
            }
        }
        stage('Push Docker Image'){
            steps{
                script{
                    docker.withRegistry('', 'Docker'){
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
