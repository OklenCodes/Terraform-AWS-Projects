# TerraformTutorials

Objective of this is to create a series for Terraform and AWS hands-on projects, that are easy to follow and understand

# **Prerequisites:**
Before you begin, you should have access to the following tools from your local machine: 

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) 
- [AWS account](https://aws.amazon.com/) 
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

# Creating AWS AutoScaling Group
[AWS AutoScaling Group](https://github.com/OklenCodes/Terraform-AWS-Tutorials/tree/main/AutoScalingGroup) - AWS Auto Scaling groups (ASGs) let you easily scale and manage a collection of EC2 instances that run the same instance configuration. I can then manage the number of running instances manually or dynamically, allowing me to lower operating costs. Since ASGs are dynamic, Terraform does not manage the underlying instances directly because every scaling action would introduce state drift. We can use Terraform lifecycle arguments to avoid drift or accidental changes.

Also related to the youtube video - https://youtu.be/1UtEyacje98

![image](https://github.com/user-attachments/assets/fed3f73d-1f9a-4f21-9a04-0c4014382052)

# Creating AWS IAM Policies 
[AWS IAM Policies](https://github.com/OklenCodes/Terraform-AWS-Tutorials/tree/main/IAMPolicies) - There are advantages to managing IAM policies in Terraform rather than manually in AWS. With Terraform, I can reuse these policy templates and ensure the principle of least privilege with resource interpolation.

In this tutorial, I will create an IAM user and an S3 bucket. Then, I will map permissions for that bucket with an IAM policy. Finally, I will attach that policy to the new user and learn how to iterate on more complex policies.
Also related to the youtube video - https://youtu.be/gHDsv6K31bI

![image](https://github.com/OklenCodes/Terraform-AWS-Tutorials/blob/main/IAMandS3Policy/IAM%20image.PNG)


# Creating simple AWS Infrastructure

[Simple AWS Infratstructure](https://github.com/OklenCodes/Terraform-AWS-Tutorials/tree/main/Simple-AWS-Infrastructure) - In this tutorial, I will use Terraform to create a simple AWS Infrastructure that comprises of VPC, Security group, public and private subnet, route table, internet gateay and finally EC2 instances. 

Youtube video - https://www.youtube.com/watch?v=YBoIBZ5VSAU

![image](https://github.com/user-attachments/assets/128dfd78-b027-4d3a-82bd-96be3f4e9da1)

# Terraform provisioning EC2 instance with Jenkins, Docker and Sonarqube

[Terraform-EC2-Jenkins-SonarQube](https://github.com/OklenCodes/Terraform-AWS-Tutorials/tree/main/Terraform-EC2-Jenkins-SonarQube) - In this tutorial, I will use terraform to firstrly create a EC2 instance and a Security group. In addition to this I will create a shellscript that will upgrade the EC2 instance then install Jenkins  and Docker. 
Following the Docker installation I will then run SonarQube from the docker image
Also related to the youtube video - https://youtu.be/gHDsv6K31bI

![image](https://github.com/user-attachments/assets/afa81ce2-3d6d-4a22-bb15-9ee9cd337ce1)
I have also added the Install.sh script for using Ubuntu as well as the AMI for t2.Large Ubuntu instance in the main.tf

Youtube Tutorial for this project - https://youtu.be/dutxZ1a1cmo

# Terraform provisioning AWS EKS
This project demonstrates how to AWS EKS using Terraform.
![image](https://github.com/user-attachments/assets/78f6ad32-d5df-427e-b049-3ee2b9c9c01b)

This video tutorial will guide you through the process of setting up a fully functional EKS cluster on AWS using Terraform's infrastructure as code capabilities. 
From creating VPC and subnets to deploying the EKS control plane and worker nodes, we'll cover all the essential steps.

Youtube Tutorial for this project - https://youtu.be/EMs9nQ6SPVQ



