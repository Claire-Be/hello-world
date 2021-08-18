variable "region" {
  default = "us-west-2"
}

variable "remote_user" {
  default = "cbeamer"
}

variable "ssh_pub_key" {
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK3GG+lA6Wm7XOk0hEgsip7qyNii/FWNO1YIlutbo4nA"
}

variable "app_repo" {
  default = "https://github.com/Claire-Be/hello-world.git"
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