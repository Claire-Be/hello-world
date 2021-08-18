data "template_file" "cloud_init_web" {
  template = file("cloudinit/web.yml")
  vars = {
    remote_user = var.remote_user
    ssh_pub_key = var.ssh_pub_key
  }
}

data "template_file" "cloud_init_orchestrate" {
  template = file("cloudinit/orchestrate.yml")
  vars = {
    remote_user = var.remote_user
    ssh_pub_key = var.ssh_pub_key
    app_repo    = var.app_repo
  }
}