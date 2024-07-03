# reactjs-CI-CD-project
# CI-CD--Project
**Build a CI/CD project using Jenkins and EKS Cluster.**

**Prerequisites:**

An AWS account with administrative privileges.
A GitHub account.
Terraform Installation for automating the deployment.
Docker Installation.
Jenkins Installation. 

**Steps:**
**1. Configure an EC2 Instance in AWS**
   
   Launch a new EC2 instance based on your preferred configuration by taking the Ubunut AMI.


**2. Install Java on Ubuntu 22.04**
   
   Connect to your EC2 instance via SSH.
   Update package lists and install Java 17.


**3. Install Jenkins on Ubuntu 22.04**
  
   Add the Jenkins repository key and source list.
   Update package lists and install Jenkins.


**4. Enable and Start Jenkins**

   Enable Jenkins to start at boot time and start the service.
   Check the status of Jenkins service.
   Install Git on Ubuntu 22.04 LTS


**5. Install Git using the apt package manager**

   Access Jenkins Web Interface


**6. Open your web browser and navigate to http://<your_instance_ip>:8080**

   Retrieve the initial administrator password using the provided command and paste it into the browser prompt.


**7. Configure Jenkins User and Credentials**

   GO to the Manage Jenkins>>Credentials>>system>>Global credentials, add the necessary credentials.


**8. Install Docker in Ubuntu 22.04**

   sudo apt install docker.io                                                                 # Install the Docker, for jenkins to interact with the Docker
   sudo usermod -aG docker $USER                                                              # Grant your user permission to run Docker commands:
   sudo chmod 666 /var/run/docker.sock                                                        # Change permissions for the Docker socket:
   sudo systemctl restart jenkins                                                             # Restart Jenkins:

**9. Install Jenkins Plugins**

   In Jenkins, go to "Manage Jenkins" -> "Plugins" -> "Available Plugins".
   Install the following plugins:
   - Docker
   - Docker Pipeline
   - Amazon ECR
   Create an ECR Repository in AWS
   Go to the AWS Management Console and navigate to the ECR service.
   Click "Create repository" and provide a name for your repository.
   Create an IAM Role with AmazonEC2ContainerRegistryFullAccess Policy
   In the AWS Management Console, navigate to the IAM service.
   Create a new role with the "AmazonEC2ContainerRegistryFullAccess" policy attached.          # this attached to EC2 instance where jenkins installed, because jenkins to authenticate the ECR registry to push the image.

**10. Install the AWS CLI on Ubuntu 22.04:**

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"          # Download the AWS CLI installation package from the official AWS website
    unzip awscliv2.zip                                                                         # Unzip the downloaded package
    sudo ./aws/install                                                                         # Install the AWS CLI

**11. Create a Jenkins Pipeline:**
    Go to the Jenkins dashboard.
    Click on "New Item" and select "Pipeline".
    Provide a name for your pipeline job.
    In the "Pipeline" definition, paste the following code snippet, replacing placeholders with your specific values
    **Follow this Groovy script for the pipline build process:**

    pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="222222222222"                                                                                        # Replace with your AWS account ID
        AWS_DEFAULT_REGION="ap-south-1"
        IMAGE_REPO_NAME="jenkins-pipeline"
        IMAGE_TAG="v1"
        REPOSITORY_URI = "22222222222.dkr.ecr.us-east-1.amazonaws.com/jenkins-pipeline"                                      # Replace with your ERC image URL
    }
   
    stages {
        
         stage('Logging into AWS ECR') {
            steps {
                script {
                sh """aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"""
                }
                 
            }
        }
        
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/sd031/aws_codebuild_codedeploy_nodeJs_demo.git']]])     
            }
        }
  
    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"""
                sh """docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"""
         }
        }
      }
    }
}

Lastely, You can verify in the AWS account, wheather ECR images is been pushed.

**The following process regarding to the CD part, where we Deploy the AWS ECR image to the EKS Cluster, using Terraform Automation Code.**

**12. Launch a EC2 machine and run the following command to install terraform**

      1. sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
      2. wget -O- https://apt.releases.hashicorp.com/gpg | \
         gpg --dearmor | \
         sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
      3. gpg --no-default-keyring \
         --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
         --fingerprint

**13. Install AWS CLI:**

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install.

**14. Execute the main.tf file provided above to deploy the ERC image to EKS cluster**


**15. Configure the Load balancer endpoint to EKS Worker node:**

     1. Access the Load Balancer Service:
         Log in to your cloud provider's management console.
         Navigate to the section dedicated to Load Balancing services.
         Create a Load Balancer:

     2. Click on "Create Load Balancer" or a similar option.
         Choose an appropriate load balancer type (e.g., Application Load Balancer for HTTP/HTTPS traffic).
         Provide a name for your load balancer.
         Configure additional settings as required by your specific service (e.g., VPC configuration, security groups).

    3. Define Target Group:
        Create a new target group or select an existing one.
        A target group is a collection of instances that the load balancer will distribute traffic to.

    4. Register Instance(s):
        In the target group configuration, specify the instance(s) you want to route traffic to. This typically involves providing instance IDs or private IP addresses.

    5. Configure Load Balancer Listener:
        Define a listener on the load balancer that listens for incoming traffic on a specific port (e.g., port 80 for HTTP traffic).
        Associate the listener with the target group you created in step 3.
      
    6. Create Load Balancer Endpoint (Optional):
        Some cloud providers allow creating an endpoint for the load balancer. This endpoint serves as a single entry point for clients to access your instances.
        (Note: This step might be named differently depending on your service. It might also be part of step 2 when creating the Load Balancer.)
   







# Terraform approach
This repository contains the code and configuration files for a React.js application that is set up with a CI/CD pipeline using Jenkins. The application is deployed to an Amazon EKS cluster.

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Getting Started](#getting-started)
   - [Cloning the Repository](#cloning-the-repository)
   - [Setting up the Jenkins Pipeline](#setting-up-the-jenkins-pipeline)
   - [Deploying to EKS](#deploying-to-eks)
4. [Project Structure](#project-structure)
5. [Contributing](#contributing)
6. [License](#license)

## Introduction
This project demonstrates how to set up a CI/CD pipeline for a React.js application using Jenkins. The application is built, tested, and deployed to an Amazon EKS cluster. The pipeline is configured using Jenkins Pipeline syntax and Jenkinsfile.

## Prerequisites
- Git
- Docker
- Kubernetes
- Terraform
- AWS CLI
- Jenkins
- React.js

## Getting Started

### Cloning the Repository
1. Clone the repository to your local machine:
```bash
git clone https://github.com/HemanthVarun/reactjs-CI-CD-project.git
```

2. Change into the project directory:
```bash
cd reactjs-CI-CD-project
```
### Creating an ec2-instance
The directory called Jenkins-server, which has a been configured to create an ec2 instance, following the terraform commands with necessary installations.

### Setting up the Jenkins Pipeline
1. Create a new Jenkins pipeline job.
2. Configure the pipeline to use the Jenkinsfile in the repository.
3. Set up the necessary environment variables and credentials in Jenkins.
4. Run the pipeline to build, test, and deploy the application.

### Deploying to EKS
1. Ensure that you have the necessary AWS credentials configured in Jenkins.
2. The pipeline uses Terraform to create the EKS cluster and deploy the application.
3. After the pipeline completes successfully, the application will be accessible via the EKS cluster's load balancer.

## Project Structure
- `Jenkinsfile`: Contains the configuration for the Jenkins pipeline.
- `Dockerfile`: Defines the Docker image for the React.js application.
- `kubernetes/`: Contains the Kubernetes manifests for deploying the application to EKS.
- `terraform/`: Contains the Terraform configuration for creating the EKS cluster.
- `src/`: Contains the source code for the React.js application.

## Contributing
If you find any issues or have suggestions for improvements, please feel free to create a new issue or submit a pull request.

## License
This project is licensed under the [MIT License](LICENSE).

Citations:
[1] https://github.com/HemanthVarun/reactjs-CI-CD-project
[2] https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/9005932/8693ed89-423e-4eae-8fe7-167c6d1adc38/paste.txt






# CloudFormation Approach 
## EKS Cluster Creation and Deployment Pipeline

## Introduction
This documentation outlines the process of creating an Amazon Elastic Kubernetes Service (EKS) cluster using AWS CloudFormation and deploying an application using a Jenkins pipeline.

## Prerequisites
- AWS account with necessary permissions
- AWS CLI installed and configured
- eksctl tool installed
- Jenkins server set up with necessary plugins and configurations


## EKS Cluster Creation
1. Open the AWS CloudFormation console.
2. Create a new stack by providing the necessary parameters, such as cluster name, region, and node type.
3. Use the following command to create the EKS cluster:

```bash
eksctl create cluster --name my-eks-cluster1 --region us-east-1 --node-type t2.small
```

4. Wait for the cluster creation process to complete.

## Jenkins Pipeline Setup
1. Create a new Jenkins pipeline job.
2. Configure the pipeline to use a Jenkinsfile named "Jenkinsfile-deployment" located in your project's repository.
3. The Jenkinsfile-deployment should contain the necessary steps to build, test, and deploy your application to the EKS cluster.

## Application Deployment
1. The Jenkins pipeline will automatically trigger when changes are pushed to the repository.
2. The pipeline will execute the steps defined in the Jenkinsfile-deployment, which includes building the Docker image, pushing it to a container registry, and deploying the application to the EKS cluster.
3. Once the deployment is successful, you can access your web application using the load balancer's DNS URL.

## Conclusion
By following this process, you can create an EKS cluster using AWS CloudFormation and deploy your application using a Jenkins pipeline. This approach ensures consistent and automated deployments, making it easier to manage and scale your application in the Kubernetes environment.
