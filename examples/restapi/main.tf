terraform {
  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.20.0"
    }
  }
}

provider "restapi" {
  uri = "http://127.0.0.1:8000"
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
