pipeline {
    agent any

   stages {
      stage('Janus KickOff') {

         steps {
            sh 'gcloud config set compute/zone us-central1-f'
            sh 'gcloud config set project afrl-janus-sp-01 '
         }
      }
   }
}
