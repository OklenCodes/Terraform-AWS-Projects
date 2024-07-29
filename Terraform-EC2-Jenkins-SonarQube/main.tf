resource "aws_instance" "jenkins" {
  ami             = "ami-055db685a6d9d5646"
  instance_type   = "t2.large" 
  key_name        = "deployer_key"
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  user_data = file("install.sh")
  
  #"${file("install.sh")}"
  #templatefile("./install.sh", {})

  tags = {
    Name = "Jenkins-SonarQube"
}

root_block_device {
volume_size = 30
  }
}

#ami for ubuntu ami-0ff591da048329e00
#ami for amazon linux ami-055db685a6d9d5646
