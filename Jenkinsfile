// Jenkinsfile
pipeline {
    agent any // Runs on your local Jenkins server/node

    environment {
        DOCKER_IMAGE = "guangqi99/bio-script:1.0"
    }

    stages {
        stage('0. Setup Workspace') {
            steps {
                checkout scm // Pulls your code from GitHub
                // Ensure the outputs directory exists before testing
                sh 'mkdir -p data results'
            }
        }

        stage('1. Build Docker Image') {
            steps {
                echo 'Building your bio-script container...'
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('2. Test Docker Container Directly') {
            steps {
                echo 'Running a quick standalone test with Docker...'
                // Manually map the directory to make sure count_bases.py runs smoothly inside Docker
                sh """
                    docker run --rm \
                    -v \$(pwd)/data:/app/data \
                    -v \$(pwd)/results:/app/results \
                    ${DOCKER_IMAGE} /app/data/sample1.fasta /app/results/sample1_gc.txt
                """
                sh 'cat results/sample1_gc.txt'
            }
        }

        stage('3. Push Image to Docker Hub') {
            steps {
                echo 'Logging into Docker Hub and pushing image...'
                // Uses Jenkins Credential Manager safely so passwords aren't exposed in code
                withCredentials([usernamePassword(credentialsId: 'dockerhub-login', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('4. Run Snakemake Orchestration') {
            steps {
                echo 'Executing Snakemake pipeline via local Docker engine...'
                // Clear old results to prove Snakemake successfully creates a brand new one
                sh 'rm -f results/sample1_gc.txt'
                
                // Instruct Snakemake to run locally while extracting the container from your system
                sh 'snakemake --cores 1 --use-docker'
                
                echo 'Printing final Snakemake report validation:'
                sh 'cat results/sample1_gc.txt'
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline has finished executing!'
        }
    }
}

