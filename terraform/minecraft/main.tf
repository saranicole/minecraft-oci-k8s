
resource "helm_release" "minecraft" {
  name       = "minecraft"
  repository = "https://itzg.github.io/minecraft-server-charts/"
  chart      = "minecraft"
  version    = var.chart_version
  values = [templatefile("${path.module}/helm/minecraft/values.tftpl", {
    accept_eula               = var.accept_eula,
    world_version             = var.world_version,
    server_type               = var.server_type,
    fabric_loader_version     = var.fabric_loader_version,
    difficulty                = var.difficulty,
    whitelist                 = var.whitelist,
    ops                       = var.ops,
    motd                      = var.motd,
    mod_urls                  = yamlencode(var.mod_urls),
    download_world_url        = var.download_world_url,
    rclone_dest_dir           = var.rclone_dest_dir,
    enable_oci_backup_bucket  = var.enable_oci_backup_bucket,
    enable_oci_load_balancer  = var.enable_oci_load_balancer,
  })]
}

resource "oci_objectstorage_bucket" "minecraft_backups" {
  count = var.enable_oci_backup_bucket ? 1 : 0
  compartment_id = var.compartment_id
  namespace      = var.bucket_namespace
  name           = "minecraft-backups"
  access_type    = "NoPublicAccess"
}

resource "kubernetes_secret_v1" "rcon-creds" {
  metadata {
    name = "rcon-creds"
  }
  data = {
    RCON_PASSWORD = var.rcon_password
  }
}

resource "kubernetes_secret_v1" "rclone-config" {
  count = var.enable_oci_backup_bucket ? 1 : 0
  metadata {
    name = "rclone-config"
  }
  data = {
    rclone.conf = templatefile("${path.module}/rclone.conf.tftpl", {
      bucket_namespace = var.bucket_namespace
      compartment_id = var.compartment_id
      region = var.region
    })
  }
}
