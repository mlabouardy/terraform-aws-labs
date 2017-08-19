provider "aws" {
   region = "us-east-1"
}

resource "aws_key_pair" "mysshkey" {
   key_name = "mysshkey"
   public_key = "${file("/home/core/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "node1" {
   ami = "ami-a4c7edb2"
   instance_type = "t2.micro"
   key_name = "mysshkey"

   tags {
     Name = "node1"
   }
}
