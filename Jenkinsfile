pipeline {
    agent any
 
    tools {
        allure 'allure'
        jdk 'jdk11'
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
                            if (Test-Path "allure-results") {
                                Remove-Item -Path "allure-results\\*" -Recurse -Force -ErrorAction SilentlyContinue
                            }

                            robot --listener allure_robotframework:allure-results/ src/test/resources/TestCases/*.robot
                            $exitCode = $LASTEXITCODE
                            if ($exitCode -ne 0) {
                                Write-Host "Robot tests had some failures. Build will continue."
                            }
                            exit 0  # Force Jenkins build to continue successfully
                        '''
            }
        }
    }

    post {
        always {
            allure([
                includeProperties: false,
                jdk: 'jdk11',
                results: [[path: 'allure-results']]
            ])
        }
    }
}
