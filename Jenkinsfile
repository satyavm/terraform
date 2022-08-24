pipeline {
    agent any
    stages {
        stage("init"){ 
            steps {
            terraform init
            }
        }
        stage("plan"){
            steps {
            terraform plan
            }
        }
        stage("apply"){
            steps {
            terraform apply
            }
        }
    }
}