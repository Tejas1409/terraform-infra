resource "aws_security_group" "this" {
  name = "dev-sg"
  vpc_id = var.vpc_id

  tags = {
  Name = "dev-sg"
  Env  = var.env
}

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
  Name = "dev-ec2"
  Env  = var.env
}
}
