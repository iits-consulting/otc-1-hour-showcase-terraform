variable "stage_name" {}
variable "vpc_flavor_id" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "vpc_cidr" {}
variable "key_pair_id" {}
variable "nodes" {
  type = map(string)
}
variable "availability_zone" {
  default = "eu-de-01"
  type = string
}
variable "container_network_type" {
  default = "vpc-router"
  type = string
}
variable "node_name_prefix" {
  default = "node"
  type = string
}