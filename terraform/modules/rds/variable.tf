variable "db_name" {
  description = "Name of the initial database"
  type        = string
  default     = "shortener"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "appuser"
}

variable "db_engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "16"
}

variable "db_instance_class" {
  description = "RDS instance size"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Storage in GB"
  type        = number
  default     = 20
}


variable "vpc_cidr" {
  type = string
}