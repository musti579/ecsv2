resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "ecs2-redis"
  engine               = "redis"
  engine_version       = "7.1"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  port                 = 6379

  # still need to add: subnet group + security group
}