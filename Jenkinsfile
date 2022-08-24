pipeline {
    agent any
        stages {
        stage("Init"){ 
            steps {
                 withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "root-key", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh 'terraform init'
            }    
            }
        }
        stage("Plan"){
    steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "root-key", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh 'terraform plan'
        }
        }
        }
        stage("Apply"){
            steps {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "root-key", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh 'terraform destroy -auto-approve'
        }
            }
        }
    }
}