resource "aws_vpc" "my_vpc"{
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet1" {
     vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.0.0/20"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = "true"

}

resource "aws_subnet" "public_subnet2" {
     vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.16.0/20"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = "true"

}

     
resource "aws_internet_gateway" "itg" {
    vpc_id = aws_vpc.my_vpc.id

}

resource "aws_eip" "geip" {
    domain = "vpc"
     
   }

resource "aws_nat_gateway" "natg" {
   allocation_id = aws_eip.geip.id
   subnet_id = aws_subnet.public_subnet1.id
}

resource "aws_route_table" "private_route_table" {
    
    vpc_id = aws_vpc.my_vpc.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "aws_nat_gateway.natg.id"
         
    }
}


 resource "aws_subnet" "private_subnet1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.128.0/20"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = "true"
 }


 resource "aws_subnet" "private_subnet2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.144.0/20"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = "true"
 }

 

resource "aws_db_subnet_group" "db_sg" {
  
  name       = "main"
  subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
}

resource "aws_route_table_association" "private_subnet1asso" {
       subnet_id = aws_subnet.private_subnet1.id
       route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet2asso"{
    subnet_id = aws_subnet.private_subnet2.id
    route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "lb_sg" {
     
     vpc_id = aws_vpc.my_vpc.id
     description = "loadbalancer_securtity_group"

     ingress {
         from_port="0"
         to_port= "0"
         protocol="-1"
         cidr_blocks=["0.0.0.0/0"]
     }
  

     egress {
         from_port="0"
         to_port= "0"
         protocol="-1"
         cidr_blocks=["0.0.0.0/0"]
     }
}

resource "aws_route_table" "public_route_table" {
    
    vpc_id = aws_vpc.my_vpc.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "aws_nat_gateway.natg.id"
         
    }
}

 
  resource "aws_route_table_association" "publicsubnet1asso" {
     subnet_id = aws_subnet.public_subnet1.id
     route_table_id = aws_route_table.public_route_table.id
    
  }

  resource "aws_security_group" "subnet_sg" {

    vpc_id = aws_vpc.my_vpc.id
    description = "web & tcp allowed"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
         from_port="0"
         to_port= "0"
         protocol="-1"
         cidr_blocks=["0.0.0.0/0"]
     }
  
  }

  resource "aws_lb" "loadbalancer" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg]
  subnets            = [aws_subnet.public_subnet1.id,aws_subnet.public_subnet2.id]
  }

  resource "aws_lb_target_group" "lb_targetgrp" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

resource "" "name" {
  
}


resource "aws_lb_listener" "My-listener" {
  load_balancer_arn = aws_lb.loadbalancer.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_targetgrp.arn
  }
}

