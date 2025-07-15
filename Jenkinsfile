pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/anurag-singh26/Demo.git'
            }
        }

        stage('Run Robot Framework Tests') {
            steps {
                sh 'mvn exec:java'
            }
        }

        stage('Archive Results') {
            steps {
                archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true
            }
        }

        // Optional: Publish Allure Report if using Allure plugin
        // stage('Allure Report') {
        //     steps {
        //         allure includeProperties: false, jdk: '', results: [[path: 'allure-results']]
        //     }
        // }
    }
}
