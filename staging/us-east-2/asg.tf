##########################################################################
####### Create Launch Template
##########################################################################

resource "aws_launch_template" "staging_lt" {
  name = "${var.environment}-lt"

  #   iam_instance_profile {
  #     name = "test"
  #   }

  #image_id = data.aws_ami.staging_ami.id
  image_id                             = "ami-085f9c64a9b75eed5"
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instanCe_type
  key_name                             = var.key_pairs_name
  vpc_security_group_ids               = [aws_security_group.staging_private_sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name         = "${var.environment}-web"
      Envinonment  = var.environment
      Provisionner = var.provisioner
    }
  }

  user_data = filebase64("web.sh")
}

##########################################################################
####### Create Auto Scaling Group
##########################################################################

resource "aws_autoscaling_group" "staging_asg" {
  name = "${var.environment}-asg"
  #availability_zones = [var.use2a, var.use2b]
  target_group_arns   = [aws_lb_target_group.staging_tg.arn]
  vpc_zone_identifier = [aws_subnet.staging_private_subnet1.id, aws_subnet.staging_private_subnet2.id]
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1

  launch_template {
    id      = aws_launch_template.staging_lt.id
    version = aws_launch_template.staging_lt.latest_version
  }
}