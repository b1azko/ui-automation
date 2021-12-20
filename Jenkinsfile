pipeline {
    agent any
    triggers {
        pollSCM('*/1 * * * *')
    }
    stages {
        stage("build-staging") {
            steps {
                script {
                    build('STAGING')
                }
            }
        }
        stage('deploy-staging') {
            steps {
                script {
                    deploy('STAGING')
                }
            }
        }
        stage('test-staging') {
            steps {
                script {
                    test('STAGING')
                }
            }
        }
        stage("build-production)") {
            steps {
                script {
                    build('PRODUCTION')
                }
            }
        }
        stage('deploy-production)') {
            steps {
                script {
                    deploy('PRODUCTION')
                }
            }
        }
        stage('test-production)') {
            steps {
                script {
                    test('PRODUCTION')
                }
            }
        }
    }
}

def sendNotification(String message, Integer status = 0) {
    sh "docker run --name mvn_tests -t -d mvn_tests"
    sh "docker exec mvn_tests bash send_notification.sh '${message}' '${status}'"
    sh "docker rm -f mvn_tests"
}

def build(String environment) {
    echo "Build on ${environment} was started"
    echo "The build number - ${env.BUILD_NUMBER}"
    sh 'echo  Execution servertime - `date`'
    env.STAGE_STATUS = 0

    sendNotification("Build on ${environment} was started", 0)
}

def deploy(String environment) {
    echo "Deploy started on ${environment}"

    sendNotification("Deploy started on ${environment}", 0)
}

def test(String environment) {
    echo "Test executed on ${environment}"

    try {
        sh "docker-compose up -d --force-recreate"
        sh "docker run -t --rm --network=test-automation-setup mvn_tests mvn clean test -Dbrowser=chrome -X -DgridURL=selenium-hub:4444"
        sh "docker rm -f selenium-hub"
        sh "docker-compose down"
        sendNotification("Test started on ${environment}", 0)
    }
    catch (exc) {
        echo "Failed on  ${environment} environment"
        sendNotification("Test faild on ${environment}", 1)
    }
}