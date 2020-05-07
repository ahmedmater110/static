pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'echo "Hello World"'
      }
    }

    stage('Lint') {
      steps {
        sh 'tidy -q -e *.html'
        sh 'hadolint Dockerfile'
      }
    }

    stage('Docker') {
      steps {
        sh 'docker build --tag=ahmed110/udacity:v2 .'
        sh 'docker run -it -p 80:80 ahmed110/udacity:v2'
      }
    }
   
    stage('Dockerhub') {
      steps {
        withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
          sh 'docker push ahmed110/udacity:v2'
        }
      }
    }
    stage('Upload to AWS') {
      steps {
        withAWS(region: 'us-east-1', credentials: 'aws-static') {
          s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file: 'index.html', bucket: 'ahmedmater')
        }

      }
    }

  }
}
