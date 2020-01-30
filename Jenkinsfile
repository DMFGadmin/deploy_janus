pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Run gcloud') {
            steps {
                gcloud --version
            }
        }
        stage('Test') {
            steps {
                echo 'Testing'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying'
            }
        }
    }
}