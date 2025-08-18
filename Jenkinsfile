pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/Greeshma-Babu-tech/Hybrid-DR-AWS'
      }
    }

    stage('Init') {
      steps {
        sh 'cd terraform'
        sh 'terraform init'
      }
    }

    stage('Validate') {
      steps {
        sh 'terraform validate'
      }
    }

    stage('Plan') {
      steps {
        sh 'terraform plan -out=tfplan'
      }
    }

    stage('Approve') {
      input {
        message "Approve deployment?"
        ok "Deploy"
      }
      steps {
        sh 'terraform apply tfplan'
      }
    }

    stage('Clean') {
      steps {
        sh 'rm -f tfplan'
      }
    }
  }
}
