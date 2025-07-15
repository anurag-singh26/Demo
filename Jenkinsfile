pipeline {
    agent any

    tools {
        nodejs "NodeJS 18" // Optional if Allure is installed via npm
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/anurag-singh26/Demo.git'
            }
        }

        stage('Run Robot Tests + Allure Report') {
            steps {
                powershell '''
                    Remove-Item -Path "allure-results\\*" -Force -ErrorAction SilentlyContinue
                    robot --listener allure_robotframework:allure-results/ src/test/resources/TestCases/*.robot
                    allure generate allure-results --clean -o allure-report
                '''
            }
        }

        stage('Publish Allure Report') {
            steps {
                publishHTML(target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'allure-report',
                    reportFiles: 'index.html',
                    reportName: 'Robot Framework Test Report'
                ])
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/allure-report/**/*.*', allowEmptyArchive: true
        }
    }
}
