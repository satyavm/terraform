pipeline {
    agent any
    stages {
        stage("init"){ 
            steps {

            sh 'terraform init'
            }
        }
        stage("plan"){
    steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "root-key", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh 'terraform plan'
        }
        }
        }
        stage("apply"){
            steps {
            sh 'terraform apply'
            }
        }
    }
}