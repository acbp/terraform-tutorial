terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~>2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:stable-alpine"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = var.containerName
  ports {
    internal = 80
    external = 80
  }
}

variable "containerName" {
  description = "container's name"
  type        = string
  default     = "tutorial"
}

output "nginxContainerId" {
  value = docker_container.nginx.id
}
output "nginxContainerName" {
  value = docker_container.nginx.name
}
