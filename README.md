# reactjs-CI-CD-project
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
# EKS Cluster Creation and Deployment Pipeline

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
