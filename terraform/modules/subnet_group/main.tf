resource "aws_db_subnet_group" "my_db_subnet_group" {
  name        = var.db_subnet_group_name
  description = var.db_subnet_group_description
  subnet_ids  = var.db_subnet_ids
}


