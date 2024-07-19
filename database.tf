resource "aws_db_instance" "mydb" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  db_subnet_group_name = aws_db_subnet_group.db_sg.id
  vpc_security_group_ids = [aws_security_group.aws_security_group.subnet_sg.id]
  username             = "user"
  password             = "pass"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}


resource "aws_security_group" "private_db_sg" {

  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port       = 8279 #default port is 3306. You can also use 3307 & 8279 like myself
    to_port         = 8279
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = [aws_security_group.lb_sg.id]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  
}