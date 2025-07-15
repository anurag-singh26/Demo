pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Code already checked out by Jenkins.'
            }
        }

        stage('Run Robot Tests with Allure') {
            steps {
                powershell '''
                    Remove-Item -Path "allure-results\\*" -Force -ErrorAction SilentlyContinue
                    robot --listener allure_robotframework:allure-results/ src/test/resources/TestCases/*.robot
                    allure generate allure-results --clean -o allure-report
                '''
            }
        }

        stage('Publish Report') {
            steps {
                publishHTML(target: [
                    reportDir: 'allure-report',
                    reportFiles: 'index.html',
                    reportName: 'Robot Test Report'
                ])
            }
        }
    }
}
