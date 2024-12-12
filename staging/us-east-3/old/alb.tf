##########################################################################
####### Create Target Group
##########################################################################

resource "aws_lb_target_group" "staging_tg" {
  name     = "${var.environment}-80-tg"
  port     = 80
  protocol = var.lb_proto_http
  vpc_id   = aws_vpc.staging_vpc.id

  tags = {
    Name         = "${var.environment}-tg"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}


##########################################################################
####### Create Application Load balancer
##########################################################################

resource "aws_lb" "staging_lb" {
  name               = "${var.environment}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.staging_public_sg.id]
  subnets            = [aws_subnet.staging_public_subnet1.id, aws_subnet.staging_public_subnet2.id]
  drop_invalid_header_fields = true

  #enable_deletion_protection = true

  tags = {
    Name         = "${var.environment}-lb"
    Envinonment  = var.environment
    Provisionner = var.provisioner
  }
}

##########################################################################
####### Create Listeners
##########################################################################

resource "aws_lb_listener" "staging_forward" {
  load_balancer_arn = aws_lb.staging_lb.arn
  port              = var.lb_port_https
  protocol          = var.lb_proto_https
  ssl_policy        = var.lb_ssl_policy
  certificate_arn   = data.aws_acm_certificate.amazon_issued.arn

  default_action {
    type = "fixed-response"
    #target_group_arn = aws_lb_target_group.staging_tg.arn
    fixed_response {
      content_type = "text/plain"
      message_body = "PAGE NOT FOUND. Please check your URL."
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "staging_refirect" {
  load_balancer_arn = aws_lb.staging_lb.arn
  port              = var.lb_port_http
  protocol          = var.lb_proto_http

  default_action {
    type = "redirect"

    redirect {
      port        = var.lb_port_https
      protocol    = var.lb_proto_https
      status_code = "HTTP_301"
    }
  }
}

##########################################################################
####### Create Listeners rules
##########################################################################

resource "aws_lb_listener_rule" "staging_rule" {
  listener_arn = aws_lb_listener.staging_forward.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.staging_tg.arn
  }

  condition {
    host_header {
      values = ["www.${var.environment}.johnyfoster.com", "${var.environment}.johnyfoster.com"]
    }
  }
}

