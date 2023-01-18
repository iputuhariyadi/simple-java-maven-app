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
	stage('Manual Approval'){
	    input message: 'Lanjutkan ke tahap Deploy?', ok: 'Proceed'
	}
	stage('Deploy') {
		sh './jenkins/scripts/deliver.sh'
		archiveArtifacts 'target/my-app-1.0-SNAPSHOT.jar'
		sh 'docker build -t my-app:latest .';
		sh 'docker run -it --rm my-app';
		sleep 60
        }
    }
}
