resource "kubernetes_role" "default" {
  metadata {
    name = "default-access"
    namespace = "default"
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_role_binding" "full_default_access" {
  metadata {
    name = "default-access"
    namespace = "default"
  }

  subject {
    kind      = "Group"
    name      = "default-access"
    api_group = "rbac.authorization.k8s.io"
  }

  role_ref {
    kind     = "Role"
    name     = kubernetes_role.default.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  depends_on = [kubernetes_role.default]
}

# readonly binding
#resource "kubernetes_cluster_role_binding" "readonly" {
#  metadata {
#    name = "readonly"
#  }
#
#  role_ref {
#    api_group = "rbac.authorization.k8s.io"
#    kind     = "ClusterRole"
#    name     = "view"
#  }
#
#  subject {
#    kind      = "Group"
#    name      = "readonly"
#  }
#}

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