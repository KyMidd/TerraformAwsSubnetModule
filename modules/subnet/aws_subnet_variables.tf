variable "subnet_group" {
  description = "Such as Corp, Inf, used to name subnets"
}
variable "subnet_addresses" {
  description = "A list of subnet addresses for the subnets"
}
variable "route_table_id" {
  type        = "list"
  description = "A list of route tables to associate with subnets"
}
variable "availability_zone" {
  type        = "list"
  description = "A list of availability zones to assign to subnets"
}
variable "vpc_id" {
  description = "VPC ID, used for building resources"
}
variable "internal" {
  description = "Functional TF tag, used to identify internal subnets and assign NACLs"
  default     = "true"
}
