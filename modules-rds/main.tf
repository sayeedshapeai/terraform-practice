resource "aws_db_instance" "database" {

  identifier = var.db_identifier

  engine = var.engine

  engine_version = var.engine_version

  instance_class = var.instance_class


  username = var.username

  password = var.password


  db_name = var.db_name


  publicly_accessible = true


  skip_final_snapshot = true


  allocated_storage      = var.storage
  vpc_security_group_ids = var.security_group_ids


  db_subnet_group_name = var.subnet_group_name


  tags = {
    Name = var.db_identifier
  }

}
