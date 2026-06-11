variable "tier2_vpc" {}
variable "ig_tier2" {}

variable "public_subnet" {}
variable "private_subnet" {}


variable "public_subnet2" {}
variable "private_subnet2" {}
variable "tier2_public_sg" {}

variable "ami_id" {
    default = "ami-03ea746da1a2e36e7"
}
variable "instance_type" {
    default = "t2.nano"
}
variable "key_name" {
    default = "web_template"
}
variable "availability_zone" {
  type = list(string)
  default = [ "us-east-2a", "us-east-2b" ]
}
variable "public_sb" {
  type = list(string)
  default = [ "public_subnet_1", "public_subnet_2" ]
}
variable "key_pair_name" {
  description = "Existing EC2 key pair name to attach to instances"
  type        = string
  default     = null
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile name for EC2 instances launched by the template"
  type        = string
}