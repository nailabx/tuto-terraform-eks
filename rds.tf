resource "aws_db_subnet_group" "this" {
  name       = "main"
  subnet_ids = module.vpc.public_subnets

  tags = merge(local.tags, {
    Name = "My DB subnet group"
  })
}

resource "aws_db_instance" "default" {
  allocated_storage = 10
  db_name = var.dbname
  identifier = var.dbname
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  password = random_password.rds_password.result
  username = "user"
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name = aws_db_subnet_group.this.name
  skip_final_snapshot  = true
  publicly_accessible =  true
  deletion_protection = false
}

resource "aws_security_group" "rds" {
  name_prefix = "${local.name}-rds"
  description = "Allow PostgreSQL inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}


resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "!@%&*()_-=+[]{}|:<>?/.,"
}

resource "aws_secretsmanager_secret" "rds_password_secret" {
  name = var.secretRDSPath
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id     = aws_secretsmanager_secret.rds_password_secret.id
  secret_string = "{\"password\":\"${random_password.rds_password.result}\", \"username\":\"${var.db_username}\"}"
}







