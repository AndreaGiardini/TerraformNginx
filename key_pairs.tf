
resource "aws_key_pair" "test-deployer" {
  key_name = "deployer-key"
  public_key = "${file("ssh/test-deployer.pub")}"
}

