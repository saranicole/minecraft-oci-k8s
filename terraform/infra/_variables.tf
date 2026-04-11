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

variable "kubernetes_worker_nodes" {
  description = "Worker node count"
  type        = number

  default = 2
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

variable "enable_minecraft_port" {
  description = "Whether to enable the port for Minecraft"
  type = bool
  default = false
}
