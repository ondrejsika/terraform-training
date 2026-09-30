terraform {
  required_providers {
    slr = {
      source = "sikalabsx/slr"
    }
  }
}

variable "text" {
  description = "The text for the dog to say"
  type        = string
}

resource "slr_dogsay" "this" {
  text = var.text
}

output "output" {
  value = slr_dogsay.this.output
}
