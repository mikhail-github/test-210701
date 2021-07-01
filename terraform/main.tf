terraform {
  required_version = ">= 0.12"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.3.0"
    }
  }
}

provider "kubernetes" {}

resource "kubernetes_deployment" "http-app" {
  metadata {
    name = var.application_name
    labels = {
      app = var.application_name
    }
  }

  spec {
    replicas = 3

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = 4
        max_unavailable = 1
      }
    }

    selector {
      match_labels = {
        app = var.application_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.application_name
        }
      }

      spec {
        container {
          image             = var.docker_image
          image_pull_policy = "Never"
          name              = var.application_name
          port {
            container_port = var.application_port
          }

          resources {
            limits = {
              cpu    = "1"
              memory = "512Mi"
            }
            requests = {
              cpu    = "0.5"
              memory = "100Mi"
            }
          }

          readiness_probe {
            http_get {
              path = var.application_healthcheck_path
              port = var.application_port
            }
            period_seconds  = 5
            timeout_seconds = 3
          }

          liveness_probe {
            http_get {
              path = var.application_healthcheck_path
              port = var.application_port
            }
            period_seconds  = 5
            timeout_seconds = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "main" {
  metadata {
    name = var.application_name
    labels = {
      app = var.application_name
    }
  }
  spec {
    selector = {
      app = var.application_name
    }
    port {
      port = var.application_port
    }

    type = "NodePort"
  }
}
