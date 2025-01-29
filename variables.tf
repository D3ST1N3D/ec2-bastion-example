# AWS region to deploy resources
variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources in."
}

# The AMI ID to use for the bastion host
variable "ami_id" {
  type        = string
  description = "The AMI ID for the EC2 instance."
}

# The instance type to use for the bastion host
variable "instance_type" {
  type        = string
  description = "The instance type for the bastion host."
}

# The subnet ID where bastion host will be created
variable "subnet_id" {
  type        = string
  description = "Subnet ID for the bastion host."
}

# The security group ID for the bastion host
variable "security_group_id" {
  type        = string
  description = "Security group ID for the bastion host."
}

# The key pair name for SSH access
variable "key_name" {
  type        = string
  description = "Key pair name for SSH access to the bastion host."
}
