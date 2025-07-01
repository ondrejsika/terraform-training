resource "aws_key_pair" "ondrejsika" {
  key_name   = "ondrejsika"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "debian" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_security_group" "web_sg" {
  name   = "${local.project}-web-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

  tags = { Name = "${local.project}-web-sg" }
}

resource "aws_instance" "web1" {
  ami                    = data.aws_ami.debian.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.ondrejsika.key_name

  user_data = <<-EOF
#!/bin/bash
apt-get update
apt-get install -y curl
curl -fsSL https://ins.oxs.cz/docker.sh | sh
docker run --name web -d -e PORT=80 --net host sikalabs/hello-world-server:generali
EOF

  tags = { Name = "${local.project}-web-1" }
}

resource "aws_instance" "web2" {
  ami                    = data.aws_ami.debian.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.ondrejsika.key_name

  user_data = <<-EOF
#!/bin/bash
apt-get update
apt-get install -y curl
curl -fsSL https://ins.oxs.cz/docker.sh | sh
docker run --name web -d -e PORT=80 --net host sikalabs/hello-world-server:generali
EOF

  tags = { Name = "${local.project}-web-2" }
}

output "web1_public_ip" {
  value = aws_instance.web1.public_ip
}

output "web2_public_ip" {
  value = aws_instance.web2.public_ip
}
