data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# resource "aws_key_pair" "terraform-aws-key-pair" {
#   key_name   = "terraform-aws"
#   public_key = var.SSH_PUBLIC_KEY
# }

resource "aws_instance" "my_first_ec2" {
  instance_type   = "t2.micro"
  ami             = data.aws_ami.amazon_linux.id
  subnet_id       = aws_subnet.public_subnet.id
  key_name        = "terraform-teste"
  security_groups = [aws_security_group.allow_icmp.id]
  associate_public_ip_address = true
  tags = {
    Name = "my_first_ec2"
  }
}

resource "aws_instance" "my_second_ec2" {
  instance_type   = "t2.micro"
  ami             = data.aws_ami.amazon_linux.id
  subnet_id       = aws_subnet.public_subnet.id
  key_name        = "terraform-teste"
  security_groups = [aws_security_group.allow_icmp.id]
  associate_public_ip_address = true
  tags = {
    Name = "my_second_ec2"
  }
}

output "my_first_ec2_ip" {
  value = aws_instance.my_first_ec2.public_ip
}

output "my_second_ec2_ip" {
  value = aws_instance.my_second_ec2.public_ip
}