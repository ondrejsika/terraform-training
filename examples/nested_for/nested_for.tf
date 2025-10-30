locals {
  networks = {
    prod = {
      cidr = "10.99.0.0/16"
      subnets = {
        a = "10.99.1.0/24"
        b = "10.99.2.0/24"
      }
    }
    dev = {
      cidr = "10.98.0.0/16"
      subnets = {
        a = "10.98.1.0/24"
        b = "10.98.2.0/24"
      }
    }
  }
}

resource "null_resource" "subnets" {
  for_each = merge([
    for net_name, net in local.networks : {
      for subnet_name, subnet_cidr in net.subnets :
      "${net_name}-${subnet_name}" => {
        network     = net_name
        subnet_name = subnet_name
        cidr        = subnet_cidr
      }
    }
  ]...)

  triggers = {
    network     = each.value.network
    subnet_name = each.value.subnet_name
    cidr        = each.value.cidr
  }
}

output "subnets" {
  value = null_resource.subnets
}
