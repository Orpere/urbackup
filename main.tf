provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "urbackup" {
  bucket = "urbackup"
  acl    = "private"

  tags = {
    Name        = "urbackup"
    Environment = "Production"
  }
}
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.urbackup_server.id
  allocation_id = aws_eip.urbackup.id
}
resource "aws_instance" "urbackup_server" {
  instance_type        = "t2.micro"
  availability_zone    = var.azone
  ami                  = "ami-0cc0a36f626a4fdf5"
  iam_instance_profile = "urbackup"
  security_groups      = ["urbackup"]
  key_name             = "orlando"
}

resource "aws_eip" "urbackup" {
  vpc = true
}

resource "aws_security_group" "urbackup" {
  name        = "urbackup"
  description = "Allow urbackup traffic"

  ingress {
    self      = true
    from_port = 55415
    to_port   = 55415
    protocol  = "tcp"
  }
  ingress {
    protocol  = "tcp"
    self      = true
    from_port = 55413
    to_port   = 55413
  }
  ingress {
    protocol  = "tcp"
    self      = true
    from_port = 55414
    to_port   = 55414
  }
  egress {
    protocol  = "udp"
    self      = true
    from_port = 35623
    to_port   = 35623
  }
  ingress {
    self        = true
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}