variable "compartment_id" {
  type        = string
  description = "The compartment to create the resources in"
  default = "ocid1.tenancy.oc1..aaaaaaaazjuasmxooxltyxcg45hpnmjbneorzvooq4xr4j5sofv34fpttsea"
}

variable "region" {
  description = "OCI region"
  type        = string

  default = "us-chicago-1"
}

variable "ssh_public_key" {
  description = "SSH Public Key used to access all instances"
  type        = string

  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCPCF0d41ciHim2y0791nx5GPKuiVr37u7lcIGjHtN5XzBW/b27pXUA5z5awfZ+REEXf4weTI5hTNe8oJYMNz7hQ9oGVNzKL6rjEClBUKGRTzI0phz+zWOwuAMi1V0mnVxFEbM2g77h2Ymlo4lHGRZgwWifgF6L3G3n6N959LLlXM5Nl+mq1+EKeVtwa9cH7IF2IrjBE1OqT1D97r8e7Xvu4yoYDC1ZPDmS/DSejAt6/CB0JDGz5wm3Itd8rPFDDcg4pnC82+9J268XfzCbuRt4FPR1L4xpxZC0/KKE0F+JySFJxuHuNWJehXrR0VAb2BZyxLxshHBzgAxYSfLZ/9b7UcvL9RO8As0Jc//KyuWymC+hjTeN+2qaK3ykizBpBk9f44fcBl20rLauS7WQxVlIZARTxek66iU0MZiRMSnZazwao1EDdpPjt4Rebkm4E+yHqEGNMLXvJN+2YsboMDPuR7rtT8jGRWI772BWR9OA5NLFiFKAp4XhbWS9WcYErzk= sarajarjoura@SaraSensibleMBP"
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
