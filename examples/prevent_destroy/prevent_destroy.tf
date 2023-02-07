// !!! Prevent Desroy !!!

resource "null_resource" "__prevent_destroy__" {
  lifecycle {
    prevent_destroy = true
  }
  depends_on = [
    null_resource.foo,
  ]
}
