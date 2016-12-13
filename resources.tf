
resource "aws_instance" "web" {
  ami = "ami-6e165d0e"
  instance_type = "t2.micro"
  key_name = "deployer-key"
  security_groups = ["webserver-sg"]

  connection {
    user = "ubuntu"
    private_key = "${file("ssh/test-deployer")}"
  }

  provisioner "file" {
    source = "manifests/default.pp"
    destination = "/home/ubuntu/default.pp"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get -y install puppet=3.8.5-2",
      "sudo puppet module install puppet-nginx --version 0.5.0",
      "sudo puppet apply default.pp"
    ]
  }
}

