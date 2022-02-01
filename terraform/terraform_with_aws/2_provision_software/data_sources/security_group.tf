data "aws_ip_ranges" "european_ec2" {
  regions  = ["eu-west-1", "eu-central-1"]
  services = ["ec2"]
}

resource "aws_security_group" "from_europe" {
  name = "from_europe"

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = slice(data.aws_ip_ranges.european_ec2.cidr_blocks, 0, 50) #lists all the IP upto 50 of them.
  }
  tags = {
    CreateDate = data.aws_ip_ranges.european_ec2.create_date # the time when the SG got created
    SyncToken  = data.aws_ip_ranges.european_ec2.sync_token # whenever there is an update teh sync token gets updated.
  }
}

