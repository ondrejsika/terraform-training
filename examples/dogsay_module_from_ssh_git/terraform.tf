module "dogsay_ssh" {
  source = "git::ssh://git@github.com/ondrejsika/terraform-training.git//modules/dogsay"

  text = "Hello from Git repository via SSH!"
}

output "dogsay_ssh_output" {
  value = module.dogsay_ssh.output
}
