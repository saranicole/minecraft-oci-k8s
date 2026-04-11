provider "oci" {
  user_ocid=var.user_ocid
  tenancy_ocid = var.compartment_id
  fingerprint=var.fingerprint
  region=var.region
  private_key_path = var.private_key_path
}
