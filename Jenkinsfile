pipeline { 
    environment { 
        registry = "zeusankitardeshana/angular-demo-app" 
        registryCredential = 'dockerhub_creds' 
        dockerImage = '' 
    }
    agent any 
    stages { 
        stage('Cloning our Git') { 
            steps { 
                git 'https://github.com/ankit-ardeshana/angular-demo-app.git' 
            }
        } 
        stage('Building our image') { 
            steps { 
                script { 
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
                }
            } 
        }
        stage('Deploy our image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push() 
                    }
                } 
            }
        } 
        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        }
	      stage('Deploy') {
            steps { 
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage = docker.image(registry + ":$BUILD_NUMBER")
                        sh "docker pull ${dockerImage.imageName()}"
                        sh "docker run -d -p 8081:8080 ${dockerImage.imageName()}"
                    }
                }
            }
        }
    }
}
