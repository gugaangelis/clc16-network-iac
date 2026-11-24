## Adicionado um Bucket para o remote state do terraform, para que seja possivel o uso do terraform em equipe, e tambem para que seja possivel o uso do terraform cloud, caso seja necessario. ##
terraform {
  backend "s3" {
    bucket       = "terraform-state-gustavo-angelis-clc16-211125440922-us-east-1-an"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}