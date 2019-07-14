variable "region" {
  description = "AWS London region to launch servers"
  default     = "eu-west-2"
}

variable "credentials" {
  default     = "~/.aws/credentials"
  description = "Profiles containing aws_access_key_id and aws_secret_access_key"
}

variable "cluster-name" {
  default     = "ecs"
  type        = "string"
  description = "Name of the ECS cluster to be provisioned"
}
