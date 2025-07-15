pipeline {
    agent any

    tools {
        allure 'allure' // This name should match what you set in Global Tool Config
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Code already Checked out by Jenkins.'
            }
        }

        stage('Run Robot Tests') {
            steps {
                powershell '''
                    Remove-Item -Path "allure-results\\*" -Force -ErrorAction SilentlyContinue
                    robot --listener allure_robotframework:allure-results/ src/test/resources/TestCases/*.robot
                '''
            }
        }
    }

    post {
        always {
            allure([
                includeProperties: false,
                jdk: '',
                results: [[path: 'allure-results']]
            ])
        }
    }
}
