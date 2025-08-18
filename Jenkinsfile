pipeline {
  agent any

  tools {
    terraform 'terraform-1.8.0' 
  }
  environment {
    AWS_REGION = 'us-east-1'
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

    stage('Clean') {
      steps {
        dir('terraform') {
          sh 'rm -f tfplan'
        }
      }
    }
  }
}
