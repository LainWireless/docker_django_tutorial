pipeline {
    environment {
        IMAGEN = "lainwireless/django_tutorial_jenkins"
        LOGIN = 'USER_DOCKERHUB'
    }
    agent none
    stages {
        stage("Desarrollo") {
            agent {
                docker { image 'python:3'
                args '-u root:root'
                }
            }
            stages {
                stage('Clonacion') {
                    steps {
                        git branch:'main',url:'https://github.com/LainWireless/django_tutorial_desarrollo.git'
                    }
                }
                stage('Instalacion') {
                    steps {
                        sh 'pip install -r requirements.txt'
                    }
                }
                stage('Test')
                {
                    steps {
                        sh 'python3 manage.py test'
                    }
                }
            }
        }
        stage("Construccion") {
                agent any
                stages {
                    stage('Clonacion') {
                        steps {
                            git branch:'main',url:'https://github.com/LainWireless/docker_django_tutorial.git'
                        }
                    }
                    stage('BuildImage') {
                        steps {
                            script {
                                newApp = docker.build "$IMAGEN:latest"
                            }
                        }
                    }
                    stage('UploadImage') {
                        steps {
                            script {
                                docker.withRegistry( '', LOGIN ) {
                                    newApp.push()
                                }
                            }
                        }
                    }
                    stage('RemoveImage') {
                        steps {
                            sh "docker rmi $IMAGEN:latest"
                        }
                    }
                }
            }           
        }
        post {
            always {
                mail to: 'ivanpicas88@gmail.com',
                subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
                body: "${env.BUILD_URL} has result ${currentBuild.result}"
            }
        }
}