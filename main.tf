resource "aws_network_interface" "main" {
  count           = "${var.cnt}"
  subnet_id       = "${element(var.subnet_ids, count.index)}"
  private_ips     = ["${cidrhost(element(var.subnet_cidr, count.index), 6)}"]
  security_groups = ["${aws_security_group.kafka-server.id}"]
}

resource "aws_instance" "kafka" {
  count                   = "${var.cnt}"
  ami                     = "${var.ami}"
  instance_type           = "${var.instance_type}"
  ebs_optimized           = "${var.ebs_optimized}"
  disable_api_termination = "${var.disable_api_termination}"
  monitoring              = "${var.monitoring}"
  key_name 		  = "${aws_key_pair.default.id}"

  network_interface {
    network_interface_id = "${element(aws_network_interface.main.*.id, count.index)}"
    device_index         = 0
  }

  tags = {
    Name = "${var.name}-kafka-${count.index}"
  }
}

resource "aws_volume_attachment" "kf-instance" {
  count        = "${var.cnt}"
  device_name  = "/dev/sdb"
  volume_id    = "${aws_ebs_volume.kf[count.index].id}"
  instance_id  = "${element(aws_instance.kafka.*.id, count.index)}"
  skip_destroy = true
}

resource "aws_ebs_volume" "kf" {
  count             = "${var.cnt}"
  availability_zone = "${element(var.subnet_az, count.index)}"
  size              = 4
  type              = "io1"
  iops		    = 100
}

resource "aws_security_group" "kafka-server" {
  name   = "kafka-server"
  vpc_id = "vpc-0d2fe90286b6e30ea"

  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "TCP"
    cidr_blocks = []
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2888
    to_port     = 3888
    protocol    = "TCP"
    cidr_blocks = []
  }
}
