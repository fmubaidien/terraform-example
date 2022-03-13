provider "aws" {
  region = var.region
}

resource "aws_instance" "results_app" {
  ami           = "ami-0e472ba40eb589f49"
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_id
  security_groups = [var.results-voter-sg]

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

resource "aws_instance" "voting_app" {
  ami           = "ami-0e472ba40eb589f49"
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_id
  security_groups = [var.results-voter-sg]

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

resource "aws_instance" "worker" {
  ami           = "ami-0e472ba40eb589f49"
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_id
  security_groups = [var.worker-sg]

  tags = {
    Name = "ExampleAppServerInstance"
  }
}



#target group attachments
resource "aws_alb_target_group_attachment" "results-app-attach" {
  target_group_arn = "${var.results_target_group_arn}"
  target_id        = "${aws_instance.results_app.id}"  
  port             = 80
}

resource "aws_alb_target_group_attachment" "voter-app-attach" {
  target_group_arn = "${var.voter_target_group_arn}"
  target_id        = "${aws_instance.voting_app.id}"  
  port             = 80
}
