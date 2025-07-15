pipeline {
    agent any

    tools {
        // Ensure these match your Jenkins Global Tool Configuration names
        allure 'allure'           // Allure commandline installation
        jdk 'jdk11'               // Add this to properly set JAVA_HOME for Allure
    }

    environment {
        JAVA_HOME = "${tool 'jdk11'}"
        PATH = "${env.JAVA_HOME}/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Code Already Checked Out by Jenkins.'
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
                jdk: 'jdk11', // Reference your configured JDK name
                results: [[path: 'allure-results']]
            ])
        }
    }
}
