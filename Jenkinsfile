pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'echo "Hello World"'
        sh '''
                  echo "Multiline shell steps works too"
                  ls -lah
               '''
      }
    }

    stage('Lint HTML') {
      parallel {
        stage('Lint HTML') {
          steps {
            sh 'tidy -q -e *.html'
          }
        }

        stage('test') {
          steps {
            input ' Finished using the web site? (Click "Proceed" to continue) '
          }
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