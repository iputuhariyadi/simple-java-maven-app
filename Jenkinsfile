node {
    checkout scm
    docker.image('maven:3.8.6-eclipse-temurin-18-alpine').inside('-v /root/.m2:/root/.m2') {
        stage('Build') {
		sh 'mvn -B -DskipTests clean package'
        }
        stage('Test') {
	    try {
		sh 'mvn test'
            } catch (e) {
                echo "Test Stage Failed!"
            } finally {
                junit 'target/surefire-reports/*.xml'
            }
        }
	stage('Deliver') {
		sh './jenkins/scripts/deliver.sh'
        }
    }
}
