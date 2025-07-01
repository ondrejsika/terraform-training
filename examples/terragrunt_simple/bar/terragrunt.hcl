terraform {
  source = "../shared"
}

inputs = {
  output_dir = get_terragrunt_dir()
  content = "Bar!"
}
