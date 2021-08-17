packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "learn-packer-linux-aws"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "cbeamer-web-ubuntu-2004"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  ## 
  provisioner "shell" {
    inline = [
        "apt-get -y update",
        "apt-get -y install python3 python3-pip ansible",
        "pip3 install fastapi uvicorn",
        "mkdir -p /app",
        "git clone https://github.com/Claire-Bea/hello-world"
    ]
    environment_vars = [
        "DEBIAN_FRONTEND=noninteractive"
    ]
  }
  ## Run our playbook(s)
  # provisioner "ansible-local" {

  # }
}