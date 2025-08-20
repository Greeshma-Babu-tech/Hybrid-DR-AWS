pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
    AWS_ACCESS_KEY_ID = credentials('Access-key')
    AWS_SECRET_ACCESS_KEY = credentials('Secret-access-key')
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/Greeshma-Babu-tech/Hybrid-DR-AWS.git', branch: 'main'
      }
    }

    stage('Init') {
      steps {
        dir('terraform') {
          sh 'terraform init'
        }
      }
    }

    stage('Validate') {
      steps {
        dir('terraform') {
          sh 'terraform validate'
        }
      }
    }

    stage('Plan') {
      steps {
        dir('terraform') {
          sh 'terraform plan -out=tfplan'
        }
      }
    }

    stage('Approve') {
      input {
        message "Approve deployment?"
        ok "Deploy"
      }
      steps {
        dir('terraform') {
          sh 'terraform apply tfplan'
        }
      }
    }
    stage('Approve') {
      input{
        message "Approve Deletion?"
        ok "Delete"
    }
    steps {
      dir('terraform'){
        sh 'terraform destroy tfplan'
      }
    }
    }
    stage('Clean') {
      steps {
        dir('terraform') {
          sh 'rm -f tfplan'
        }
      }
    }
  }
}
