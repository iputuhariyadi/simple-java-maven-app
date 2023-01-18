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
	    input message: 'Lanjutkan ke tahap Deploy?'
	}
	stage('Deploy') {
		sh './jenkins/scripts/deliver.sh'
		archiveArtifacts 'target/my-app-1.0-SNAPSHOT.jar'
		sh 'ssh-keyscan -H 52.221.194.5 >> ~/.ssh/known_hosts'
		sh "scp -i /var/jenkins_home/workspace/submission-cicd-pipeline-iputuhariyadi/notes-implementasi-cicd.pem /var/jenkins_home/workspace/submission-cicd-pipeline-iputuhariyadi/my-app-1.0-SNAPSHOT.jar  ubuntu@52.221.194.5:/home/ubuntu/my-app-1.0-SNAPSHOT.jar"
		sh "scp -i /var/jenkins_home/workspace/submission-cicd-pipeline-iputuhariyadi/notes-implementasi-cicd.pem /var/jenkins_home/workspace/submission-cicd-pipeline-iputuhariyadi/Dockerfile  ubuntu@52.221.194.5:/home/ubuntu/Dockerfile"
		sh "ssh -i /var/jenkins_home/workspace/submission-cicd-pipeline-iputuhariyadi/notes-implementasi-cicd.pem ubuntu@52.221.194.5 < commands.txt"
		sleep 60
        }
    }
}
