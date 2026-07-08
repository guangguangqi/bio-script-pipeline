// Jenkinsfile
pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "guangqi99/bio-script:1.0"
    }

    stages {
        stage('0. Setup Workspace') {
            steps {
                checkout scm
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
                echo 'Running a standalone test with built-in data...'
                // Run the script and let it save inside the container's temporary space
                sh "docker run --rm ${DOCKER_IMAGE} /app/data/sample1.fasta /app/results/sample1_gc.txt"
            }
        }

        stage('3. Push Image to Docker Hub') {
            steps {
                echo 'Logging into Docker Hub and pushing image...'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-login', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('4. Run Snakemake Orchestration on Kubernetes') {
            steps {
                echo 'Executing Snakemake pipeline via Kubernetes Pods...'
                // Clean old test files
                sh 'rm -rf results/*'
                
                // Trigger snakemake with the kubernetes executor flag!
                sh 'snakemake --cores 3 --executor kubernetes'
                
                echo 'Printing final validation reports from Kubernetes calculation:'
                sh 'cat results/sample1_gc.txt'
                sh 'cat results/sample2_gc.txt'
                sh 'cat results/sample3_gc.txt'
            }
        }

    }
}

