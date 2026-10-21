################################################################################
# Provider variables
################################################################################

variable "aws_region" {
  type        = string
  description = "AWS region to deploy to"
}

################################################################################
# Utility variables
################################################################################

variable "environment" {
  type        = string
  description = "Environment in which resources are deployed"
}

variable "product_name" {
  type        = string
  description = "Product / platform name, used in resource names"
}

variable "tags" {
  description = "Map of tags to apply to every AWS resource created by this module (cache, user, user group, security group, secret). Merged over the module's Name tag; these tags win on conflict."
  type        = map(string)
  default     = {}
}

################################################################################
# Networking variables
################################################################################
variable "vpc_id" {
  type        = string
  description = "VPC to be used by Elasticache Redis cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs to use for this Elasticache Redis deployment"
  default     = []
}

################################################################################
# Elasticache Valkey params
################################################################################

variable "redis_allowed_security_group_ids" {
  type = list(string)
}

variable "snapshot_time" {
  type    = string
  default = "05:00"
}

variable "engine_version" {
  type    = string
  default = "7"
}

variable "data_storage_max" {
  type    = number
  default = 2
}

variable "ecpu_per_second_max" {
  type    = number
  default = 1000
}

variable "create_valkey_user_and_secret" {
  type    = bool
  default = true
}

variable "valkey_extra_user_ids" {
  type        = list(string)
  description = "IDs of existing ElastiCache users to add to the Valkey user group in addition to the users this module creates, e.g. [\"default-valkey\"] to keep the engine's built-in default user in the group. Only applied when create_valkey_user_and_secret is true."
  default     = []
}

variable "valkey_extra_users" {
  type = map(object({
    access_string = optional(string, "on ~* +@all")
  }))
  description = "Extra ElastiCache users to create and add to the Valkey user group, keyed by a short name. Each user is named <resource_tag>-valkey-<key> (user_id and user_name), gets a generated password and a Secrets Manager secret of the same name containing {username, password}. Only applied when create_valkey_user_and_secret is true."
  default     = {}
}

variable "snapshot_arns_to_restore" {
  type        = list(string)
  description = "ARN(s) of existing ElastiCache snapshot(s) to restore the serverless cache from. Redis snapshots only (AWS limitation)."
  default     = null
}