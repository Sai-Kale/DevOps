resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "ap-northeast-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh" #this will attach this ebs volume to the ec2 instance but still we need run few commands within the instance for that to get mounted.
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.example.id
}
