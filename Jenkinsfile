pipeline {
    agent any
    stages {
        stage("init"){
            terraform init
        }
        stage("plan"){
            terraform plan
        }
        stage("apply"){
            terraform apply
        }
    }
}