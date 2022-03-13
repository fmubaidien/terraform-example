provider "aws" {
  region  = "us-east-1"
}

resource "aws_db_instance" "results" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "13.1"
  instance_class       = "db.t3.micro"
  name                 = "results"
  username             = "results"
  password             = "password"
  db_subnet_group_name   = aws_db_subnet_group.private.name
  vpc_security_group_ids = [var.database-sg.id]
  parameter_group_name = aws_db_parameter_group.results.name
  security_group_names = [var.database-sg.name]
  publicly_accessible    = false
  skip_final_snapshot    = true
}

resource "aws_db_parameter_group" "results" {
  name   = "results"
  family = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_subnet_group" "private" {
  name       = "private"
  subnet_ids = [var.private_subnet.id]
}