resource "aws_lb" "front" {
  name               = "front-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = ["${aws_subnet.publicsubnets.id}"]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}

#http voter target group
resource "aws_alb_target_group" "voter-group" {
  name     = "voter-alb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.Main.id}"
  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/"
    port = 80
  }
}

#http results target group
resource "aws_alb_target_group" "results-group" {
  name     = "results-alb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.Main.id}"
  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/"
    port = 80
  }
}

#http listener
resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = "${aws_lb.front.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.results-group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "http_listener_rule" {
  listener_arn = "${aws_alb_listener.listener_http.arn}"   
  action {    
    type             = "forward"    
    target_group_arn = "${aws_alb_target_group.voter-group.id}"  
  }   
  condition {    
    path_pattern {    
    values = ["/voter"]
    }  
  }
  action {    
    type             = "forward"    
    target_group_arn = "${aws_alb_target_group.results-group.id}"  
  }   
  condition {    
    path_pattern {    
    values = ["/results"]
    }  
  }
}

#https listener
resource "aws_alb_listener" "listener_https" {
  load_balancer_arn = "${aws_lb.front.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "${var.certificate_arn}"
  default_action {
    target_group_arn = "${aws_alb_target_group.results-group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "https_listener_rule" {
  listener_arn = "${aws_alb_listener.listener_https.arn}"    
  action {    
    type             = "forward"    
    target_group_arn = "${aws_alb_target_group.voter-group.id}"  
  }   
  condition {    
    path_pattern {    
    values = ["/voter"]
    }  
  }
  action {    
    type             = "forward"    
    target_group_arn = "${aws_alb_target_group.results-group.id}"  
  }   
  condition {    
    path_pattern {    
    values = ["/results"]
    }  
  }
}

