variable "cnt" {
  description = "Size of the Kafka cluster."
  default     = 3
}

variable "subnet_ids" {
  type        = "list"
  description = "List of subnet ids. (the order should be the same of subnet_cidr var."
}

variable "subnet_cidr" {
  type        = "list"
  description = "List of subnet cidr."
}

variable "ami" {
  type        = "string"
  description = "The AMI to use for the instance."
}

variable "ebs_optimized" {
  description = "EC2 detailed monitoring."
  default     = true
}

variable "disable_api_termination" {
  description = ""
  default     = false
}

variable "monitoring" {
  description = ""
  default     = true
}

variable "tags" {
  type        = "map"
  description = "Extra tags to add on the created subnets."
  default     = {}
}

variable "name" {
  type        = "string"
  description = ""
}

variable "instance_type" {
  type = "string"
  default = "m5.large"
  description = ""
}

variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-1"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "/Users/marvinlandicho/Documents/AWS/jumphost-pubkey.rsa"
}

variable "subnet_az" {
  description = "Availability Zones"
  type = list
}
