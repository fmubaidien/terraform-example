#security group for alb
resource "aws_security_group" "alb" {
  name        = "alb_sg"
  description = "Terraform load balancer security group"
  vpc_id      = "${aws_vpc.Main.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# results and voting app security group
resource "aws_security_group" "results-voting_sg" {
    name = "results-voting-sg"
    description = "a security group for the results and voting applications"
    vpc_id      = "${aws_vpc.Main.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups =  ["${aws_security_group.alb.id}"]
  } 

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups =  ["${aws_security_group.alb.id}"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#security group for the worker
resource "aws_security_group" "worker_sg" {
    name = "worker-sg"
    description = "a security group for the results and voting applications"
    vpc_id      = "${aws_vpc.Main.id}"


  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}