resource "aws_security_group" "alb-sg" {
  name = "alb-security-group"
  vpc_id = aws_vpc.main.id
  description = "security group for alb. internet facing"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    name = "alb-sg"
  }
}

resource "aws_security_group" "app-sg" {
  name = "app-security-group"
  vpc_id = aws_vpc.main.id
  description = "security group for instances. allowing the traffic only from alb"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    security_groups = [ aws_security_group.alb-sg.id ]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "TCP"
    security_groups = [ aws_security_group.alb-sg.id ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}