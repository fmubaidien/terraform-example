resource "aws_elasticache_cluster" "example" {
  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  subnet_group_name    = aws_db_subnet_group.private.name
  security_group_names = [var.database-sg.name]
  engine_version       = "3.2.10"
  port                 = 6379
}

resource "aws_elasticache_subnet_group" "private" {
  name       = "private"
  subnet_ids = [var.private_subnet.id]
}