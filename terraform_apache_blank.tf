provider "aws" {
  region     = "eu-central-1"
  access_key = "" # Access key here
  secret_key = "" # Secret key here
}

resource "aws_instance" "web_server" {
  ami                    = "ami-0e342d72b12109f91"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sec_web.id]
  user_data              = file("user_data.sh")

  tags = {
    Name    = "web_server"
    owner   = "" # Your name here
    project = "Terraform automate build"
  }

}


resource "aws_security_group" "sec_web" {
  name        = "sec group for web"
  description = "Inboud and outbound"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
