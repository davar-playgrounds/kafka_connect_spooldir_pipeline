data "aws_availability_zones" "all" {}
variable "region" {}
variable "shared_credentials_file" {}
variable "profile" {}

# Defining the provider
provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.shared_credentials_file}"
  profile                 = "${var.profile}"
}

# Defining the VPC

resource "aws_vpc" "flume_kafka_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags {
    name = "flume_kafka"
  }
}

# Defining the Security Group

resource "aws_security_group" "flume_kafka_sg" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.flume_kafka_vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    name = "flume_kafka"
  }
}

# Defining the Subnets

resource "aws_subnet" "flume_kafka_subnet" {
  vpc_id                  = "${aws_vpc.flume_kafka_vpc.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${data.aws_availability_zones.all.names[0]}"
  map_public_ip_on_launch = true

  tags {
    name = "flume_kafka"
  }
}

# Defining an Internet Gateway

resource "aws_internet_gateway" "flume_kafka_ig" {
  vpc_id = "${aws_vpc.flume_kafka_vpc.id}"

  tags {
    name = "flume_kafka"
  }
}

# Defining Routing Tables

resource "aws_route_table" "flume_kafka_rt" {
  vpc_id = "${aws_vpc.flume_kafka_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.flume_kafka_ig.id}"
  }

  tags {
    name = "flume_kafka"
  }
}

# Setting the Route Table Associations

resource "aws_route_table_association" "public-rt-1" {
  subnet_id      = "${aws_subnet.flume_kafka_subnet.id}"
  route_table_id = "${aws_route_table.flume_kafka_rt.id}"
}

# Defining the EC2 instance

resource "aws_instance" "flume_kafka_ec2" {
  count                  = 4
  ami                    = "ami-0799ad445b5727125"
  instance_type          = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.flume_kafka_sg.id}"]
  subnet_id              = "${aws_subnet.flume_kafka_subnet.id}"
  key_name               = "csaa_ec2_key"

  tags {
    name = "flume_kafka"
  }
}

output "ec2_ips" {
  value = ["${aws_instance.flume_kafka_ec2.*.public_ip}"]
}