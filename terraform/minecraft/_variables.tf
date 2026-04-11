variable "compartment_id" {
  type        = string
  description = "The compartment to create the resources in"
  default = null
}

variable "region" {
  description = "OCI region"
  type        = string

  default = null
}

variable "ssh_public_key" {
  description = "SSH Public Key used to access all instances"
  type        = string

  default = null
}

variable "kubernetes_version" {
  # https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengaboutk8sversions.htm
  description = "Version of Kubernetes"
  type        = string

  default = "v1.35.0"
}

variable user_ocid {
  description = "OCID of the User"
  type = string
  default = null
}

variable "fingerprint" {
  description = "Fingerprint of the OCI Private Key"
  type = string
  default = null
}

variable "private_key_path" {
  description = "Path to the OCI Private Key"
  type = string
  default = null
}

variable "bucket_namespace" {
  description = "Namespace for the Object Storage Bucket"
  type = string
  default = null
}

variable "chart_version" {
  description = "Version of the chart to install"
  type = string
  default = "5.1.2"
}

#################################
##  Minecraft Variables
#################################

# Change this to TRUE to accept the EULA
variable "accept_eula" {
  description = "Does the user accept the EULA"
  type = string
  default = "FALSE"
}

variable "world_version" {
  description = "The Minecraft Server Version"
  type = string
  default = null
}

variable "server_type" {
  description = "The Minecraft Server Type, ie VANILLA, FABRIC, etc"
  type = string
  default = null
}

variable "fabric_loader_version" {
  description = "The Fabric loader version to use"
  type        = string
  default     = null
}

variable "difficulty" {
  description = "The game difficulty, ie peaceful, easy, normal, hard"
  type        = string
  default     = null
}

variable "whitelist" {
  description = "Comma-separated list of players allowed on the server"
  type        = string
  default     = null
}

variable "ops" {
  description = "Comma-separated list of players with operator permissions"
  type        = string
  default     = null
}

variable "motd" {
  description = "The message of the day displayed in the server list"
  type        = string
  default     = null
}

variable "mod_urls" {
  description = "List of URLs to download mod JAR files from"
  type        = list(string)
  default     = null
}

variable "download_world_url" {
  description = "URL to download the world data from"
  type        = string
  default     = null
}

variable "rclone_dest_dir" {
  description = "The destination directory for rclone"
  type        = string
  default     = null
}

variable "enable_oci_backup_bucket" {
  description = "Set to true to create a backup bucket on Oracle"
  type = bool
  default = false
}

variable "enable_oci_load_balancer" {
  description = "Set to true to enable a free load balancer on Oracle Cloud"
  type = bool
  default = false
}

variable "rcon_password" {
  description = "Password to use for RCON backups"
  type = string
  default = null
}
