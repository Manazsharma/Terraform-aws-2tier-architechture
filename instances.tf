resource "aws_instance" "instance1" {
  ami="ami-0b72821e2f351e396"
  instance_type = "t2.micro"
  associate_public_ip_address= true
  subnet_id = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.subnet_sg]
  user_data = <<-EOF
    #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        echo "<html><body><h1>This is tier 1 Architechture </h1></body></html>" > /var/www/html/index.html
     EOF
}

resource "aws_instance" "instance2" {
  ami="ami-01fccab91b456acc2"
  instance_type = "t2.micro"
  associate_public_ip_address= true
  subnet_id = aws_subnet.public_subnet2.id
  vpc_security_group_ids = [aws_security_group.subnet_sg]
  user_data = <<-EOF
    #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        echo "<html><body><h1>This is tier 1 Architechture </h1></body></html>" > /var/www/html/index.html
     EOF
}


