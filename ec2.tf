
# use default VPC

resource "aws_default_vpc" "default_vpc" {

}


resource "aws_instance" "project1" {
    ami = var.ami
    instance_type = var.instance_type

# refering key that already exist
    key_name = var.keypair

# refering security group created earlier
    security_groups = [aws_security_group.sg.name]

    user_data = <<-EOF
    #!/bin/bash
    echo "*** Installing apache2"
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "*** Completed Installing apache2"
    EOF

    tags = {
      Name = "project1"
      Env = "dev"
    }
}

terraform {
  backend "remote" {
    organization = "FOLLY"

    workspaces {
      name = "test-repo-w"
     }
   }
 }
