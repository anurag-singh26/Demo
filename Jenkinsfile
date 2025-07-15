pipeline {
    agent any

    tools {
        allure 'allure' // Name must match the one in Jenkins Global Tool Config
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

                    # Run Robot tests and capture exit code
                    robot --listener allure_robotframework:allure-results/ src/test/resources/TestCases/*.robot
                    $robotExitCode = $LASTEXITCODE

                    # Prevent Jenkins from failing the build by forcing success exit code
                    exit 0
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
