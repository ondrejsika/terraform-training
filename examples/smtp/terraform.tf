terraform {
  required_providers {
    smtp = {
      source  = "venkadeshwarank/smtp"
      version = "0.3.1"
    }
  }
}

provider "smtp" {
  authentication = false
  host           = "127.0.0.1"
  port           = "1025"
}

resource "smtp_send_mail" "example" {
  to      = ["to@example.com"]
  from    = "from@example.com"
  subject = "First Terraform plugin"
  body    = "My first mail goes good."
}
