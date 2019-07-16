resource "aws_key_pair" "default" {
  key_name = "kafkaServersKeyPair"
  public_key = "${file("${var.key_path}")}"
}
