variable "region" {
  default = "us-west-2"
}

variable "vpc_cidr_block" {
  default = "10.14.0.0/16"
}

variable "vpc_subnet_cidr_blocks" {
  #type = object
  default = {
    pub_1  = "10.14.0.0/28",
    pub_2  = "10.14.0.32/28",
    priv_1 = "10.14.0.64/28",
    priv_2 = "10.14.0.96/28"
  }
}