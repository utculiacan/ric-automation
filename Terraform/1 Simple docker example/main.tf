terraform {
  required_providers {
    docker = {
      #Change latest version: https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs
      source = "kreuzwerker/docker"
      version = "~> 3.5.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}