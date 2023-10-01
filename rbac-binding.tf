# readonly binding
resource "kubernetes_cluster_role_binding" "readonly" {
  metadata {
    name = "readonly"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind     = "ClusterRole"
    name     = "view"
  }

  subject {
    kind      = "Group"
    name      = "readonly"
  }
}

# admin binding
resource "kubernetes_cluster_role_binding" "admin" {
  metadata {
    name = "k8s-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind     = "ClusterRole"
    name     = "cluster-admin"
  }

  subject {
    kind      = "Group"
    name      = "k8s-admin"
  }
}