resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "testing"
  }
}

resource "aws_subnet" "us-east-1a-public" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.us_east_1a_public_cidr}"
  availability_zone = "${lookup(var.availability_zones, var.us_east_1a_public_cidr)}"

  tags {
    Name = "us-east-1a-public"
  }
}

resource "aws_subnet" "us-east-1b-public" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.us_east_1b_public_cidr}"
  availability_zone = "${lookup(var.availability_zones, var.us_east_1b_public_cidr)}"

  tags {
    Name = "us-east-1b-public"
  }
}

resource "aws_subnet" "us-east-1a-private" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.us_east_1a_private_cidr}"
  availability_zone = "${lookup(var.availability_zones, var.us_east_1a_private_cidr)}"

  tags {
    Name = "us-east-1a-private"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "igw"
  }
}

resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "1a-public-rt" {
  subnet_id = "${aws_subnet.us-east-1a-public.id}"
  route_table_id = "${aws_route_table.default.id}"
}

resource "aws_route_table_association" "1b-public-rt" {
  subnet_id = "${aws_subnet.us-east-1b-public.id}"
  route_table_id = "${aws_route_table.default.id}"
}
