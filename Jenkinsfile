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
        withCredentials([<object of type com.cloudbees.jenkins.plugins.awscredentials.AmazonWebServicesCredentialsBinding>]) {
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