pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'echo "Hello World"'
        sh 'pwd'
      }
    }

    stage('Lint') {
      steps {
        sh 'tidy -q -e index.html'
        sh 'hadolint Dockerfile'
      }
    }

    stage('Docker') {
      steps {
        sh 'docker build --tag=ahmed110/udacity:v2 .'
      }
    }
   
    stage('Dockerhub') {
      steps {
        withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
          sh 'docker push ahmed110/udacity:v2'
        }
      }
    }

    stage('Deployment') {
      steps {
        withAWS(region: 'us-east-1', credentials: 'aws-static') {
          sh 'kubectl get nodes'
          sh 'kubectl apply -f nginx-deployment.yaml'
          sh 'kubectl apply -f load-balancer.yaml'
          sh 'kubectl get pods'
          sh 'kubectl get svc'
        }
      }
    }

    stage('Wait user approval') {
      steps {
             input "Ready to start RollingUpdate ?"
      }
    }
    
    stage('RollingUpdate') {
      steps {
        withAWS(region: 'us-east-1', credentials: 'aws-static') {
          sh 'kubectl set image deployment/nginx-deployment nginx=ahmed110/udacity:v3'
          sh 'kubectl describe deployments'
        }
      }
    }
 

  }
}
