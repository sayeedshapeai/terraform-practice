variable "db_username" {
	description = "Master DB username"
	type        = string
	default     = "admin"
}

variable "db_password" {
	description = "Master DB password (sensitive)"
	type        = string
	sensitive   = true
	default     = "0852963@Sl"
}

variable "db_allocated_storage" {
	description = "Allocated storage (GB) for the DB"
	type        = number
	default     = 20
}
