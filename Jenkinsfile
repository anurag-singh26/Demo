pipeline {
    agent any

    tools {
        // Optional: If you need to define tools like Python or Allure CLI
    }

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
                    robot --listener allure_robotframework:allure-results/ *.robot
                '''
            }
        }

        stage('Generate Allure Report') {
            steps {
                powershell '''
                    allure generate allure-results --clean -o allure-report
                '''
            }
        }

        stage('Publish Report') {
            steps {
                publishHTML(target: [
                    reportDir: 'allure-report',
                    reportFiles: 'index.html',
                    reportName: 'Allure Report',
                    keepAll: true
                ])
            }
        }
    }
}
