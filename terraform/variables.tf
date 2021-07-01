variable "application_name" {
  description = "Application name"
  default     = "http-app"
}

variable "application_port" {
  description = "Network port exposed by the application"
  default     = 8000
}

variable "application_healthcheck_path" {
  description = "Application http path for healthchecks"
  default     = "/healthcheck"
}

variable "docker_image" {
  description = "Application docker image"
}
