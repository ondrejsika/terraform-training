terraform {
  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.20.0"
    }
  }
}

provider "restapi" {
  uri = data.vault_kv_secret_v2.restapi.data.uri
}

resource "restapi_object" "hello" {
  path = "/hello"
  data = jsonencode(
    {
      id      = 1
      message = "Hello World!"
    }
  )
}

resource "restapi_object" "ahoj" {
  path = "/ahoj"
  data = jsonencode(
    {
      id      = restapi_object.hello.id
      message = "Ahoj Svete!"
    }
  )
}
