#!/bin/bash
#Installing on amazon linux
#install java
echo "installing Java..."
sudo yum install java-11-amazon-corretto-headless -y
sudo yum install java-11-amazon-corretto -y
sudo yum install java-11-amazon-corretto-devel -y
sudo yum install java-11-amazon-corretto-jmods -y 
echo "Java completed..."

#install Jenkins 
echo "Installing Jenkins..."
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key    #import key from jenkins
yum install jenkins -y
sudo su -   # Become root user
systemctl enable jenkins
systemctl start jenkins
systemctl status jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "Installed Jenkins..."

#Docker
echo "Installing Docker.."
sudo yum update -y
sudo amazon-linux-extras install docker
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
echo "Docker Installed..."
sudo su - #Need to restart terminal so docker permissions take effect

#RunSonarQube
docker run -d --name sonarqube -p 9000:9000 sonarqube:latest

#Installing trivy
rpm -ivh https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.rpm
echo "Trivy installed..."
