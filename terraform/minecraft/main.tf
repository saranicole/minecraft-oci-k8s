
resource "helm_release" "minecraft" {
  name       = "minecraft"
  repository = "https://itzg.github.io/minecraft-server-charts/"
  chart      = "minecraft"
  version    = "5.1.2"
  values = [templatefile("${path.module}/helm/minecraft/values.tftpl", {})]
}

resource "oci_objectstorage_bucket" "minecraft_backups" {
  compartment_id = var.compartment_id
  namespace      = "axiyuxi1vimf"
  name           = "minecraft-backups"
  access_type    = "NoPublicAccess"
}
