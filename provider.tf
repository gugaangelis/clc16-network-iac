terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"


# Confiuguara as tag's defaults para todos os recursos criados
default_tags {
  tags = {
    Environment = "dev"
    Project     = "clc16-network-iac"
    Turma = "clc16"
  }
}
}