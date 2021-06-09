provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "web"{
  ami   = "ami-0aeeebd8d2ab47354"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1b"
  associate_public_ip_address = "true"
  key_name = "bastion"
  tags = {

    Name = "webserver"
  }
   provisioner "file" {
    source      = "script.sh"
    destination = "./script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 775 ./script.sh",
      "sudo ./script.sh",
    ]
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    host = "${aws_instance.web.public_ip}"
    private_key = file("bastion.pem")
    agent = false
    timeout = "2m"
  }
}
