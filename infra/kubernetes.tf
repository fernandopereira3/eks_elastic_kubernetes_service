resource "kubernetes_deployment" "django-api" {
  metadata {
    name = "django-api"
    labels = {
      nome = "django-api"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        nome = "django-api"
      }
    }

    template {
      metadata {
        labels = {
          nome = "django-api"
        }
      }

      spec {
        container {
          image = "499999449098.dkr.ecr.us-west-2.amazonaws.com/producao"
          name  = "django-api"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/clientes/"
              port = 8000
            }

            initial_delay_seconds = 3
            period_seconds        = 60
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "loadbalancer" {
  metadata {
    name = "loadbalance-django"
  }
  spec {
    selector = {
      nome = "django-api"
    }
    port {
      port        = 8000
      target_port = 8000
    }
    type = "LoadBalancer"
  }
}

# data "kubernetes_service" "nome_dns" {
#   metadata {
#     name = "loadbalance-django"
#   }
# }

# output "url" {
#   value = data.kubernetes_service.nome_dns.status
# }