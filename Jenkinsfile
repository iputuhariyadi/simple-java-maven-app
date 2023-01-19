node {
    checkout scm
    stage('Build') {
    	docker.image('maven:3.8.6-eclipse-temurin-18-alpine').inside('-v /root/.m2:/root/.m2') {
		sh 'mvn -B -DskipTests clean package'
	}
    }
    stage('Test') {
    	try {
	        docker.image('maven:3.8.6-eclipse-temurin-18-alpine').inside('-v /root/.m2:/root/.m2') {
			sh 'mvn test'
		}
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
	    archiveArtifacts 'target/my-app-1.0-SNAPSHOT.jar'
	    docker.build("my-app:latest");
	    sh "ssh-keyscan -H 13.229.113.230 >> ~/.ssh/known_hosts"
	    sh "/usr/bin/scp -i /var/jenkins_home/notes-implementasi-cicd.pem /var/jenkins_home/workspace/submission-cicd-pipeline-iputuhariyadi/target/my-app-1.0-SNAPSHOT.jar  ubuntu@13.229.113.230:/home/ubuntu/my-app-1.0-SNAPSHOT.jar"
	    sh 'docker run --rm my-app'
	    sleep 60
    }
}
