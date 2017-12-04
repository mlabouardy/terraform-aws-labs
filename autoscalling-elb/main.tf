# Define launch configuration

resource "aws_launch_configuration" "previously_webcluster" {
  name = "previously_webcluster"
  image_id = "${var.ami-webserver}"
  instance_type = "${var.instance_type}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "previously_asg" {
    name = "previously_asg"
    launch_configuration = "${aws_launch_configuration.previously_webcluster.name}"
    min_size = 2
    max_size = 3

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_elb" "previously_elb" {
  name = "previously_elb"
  availability_zone = ["us-west-2a", "us-west-2b"]
  subnets = ["${aws_subnet.previously_private_us_west_2a.id}", "${aws_subnet.previously_private_us_west_2b.id}"]
  security_groups = ["${aws_security_group.previously_elb_sg.id}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }

  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "previously_elb"
  }
}
