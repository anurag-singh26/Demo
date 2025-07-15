pipeline {
    agent any

    environment {
        // Optional: if these are needed for your test, like tokens or env vars
        // EXAMPLE_AUTH = credentials('your-jenkins-cred-id')
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Code already checked out by Jenkins"
            }
        }

        stage('Run Robot Tests with Allure') {
            steps {
                powershell '''
                    echo "Cleaning old allure results..."
                    if (Test-Path "allure-results") {
                        Remove-Item -Path "allure-results\\*" -Force
                    }

                    echo "Running Robot Framework tests..."
                    robot --listener allure_robotframework:allure-results/ *.robot

                    echo "Generating Allure Report..."
                    allure generate allure-results --clean -o allure-report
                '''
            }
        }

        stage('Publish Report') {
            steps {
                echo "Publishing Robot Framework and Allure reports"
                // Add plugins or post-processing steps if needed
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/output.xml, **/log.html, **/report.html', allowEmptyArchive: true
        }

        success {
            echo '✅ Tests ran successfully!'
        }

        failure {
            echo '❌ Test failure occurred!'
        }
    }
}
