resource "oci_containerengine_cluster" "k8s_cluster" {
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version
  name               = "k8s-cluster"
  vcn_id             = module.vcn.vcn_id
  endpoint_config {
    is_public_ip_enabled = true
    subnet_id            = oci_core_subnet.vcn_public_subnet.id
  }
  options {
    add_ons {
      is_kubernetes_dashboard_enabled = false
      is_tiller_enabled               = false
    }
    kubernetes_network_config {
      pods_cidr     = "10.244.0.0/16"
      services_cidr = "10.96.0.0/16"
    }
    service_lb_subnet_ids = [oci_core_subnet.vcn_public_subnet.id]
  }
}

data "oci_containerengine_cluster_kube_config" "k8s_cluster_kube_config" {
  #Required
  cluster_id = oci_containerengine_cluster.k8s_cluster.id
}

resource "local_file" "kube_config" {
  depends_on      = [oci_containerengine_node_pool.k8s_node_pool]
  content         = data.oci_containerengine_cluster_kube_config.k8s_cluster_kube_config.content
  filename        = "../.kube.config"
  file_permission = 0400
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

data "oci_containerengine_node_pool_option" "node_pool_options" {
  node_pool_option_id = "all"
  compartment_id      = var.compartment_id
}

data "jq_query" "latest_image" {
  data  = jsonencode({ sources = jsondecode(jsonencode(data.oci_containerengine_node_pool_option.node_pool_options.sources)) })
  query = "[.sources[] | select(.source_name | test(\".*aarch.*OKE-${replace(var.kubernetes_version, "v", "")}.*\")?) .image_id][0]"
}

resource "oci_identity_tag_namespace" "k8s_node_pool" {
  compartment_id = var.compartment_id
  description    = "Tags for k8s node pool"
  name           = "k8s-node-pool"
}

resource "oci_identity_tag" "role" {
  description      = "Role tag for k8s node pool"
  name             = "role"
  tag_namespace_id = oci_identity_tag_namespace.k8s_node_pool.id
}

resource "oci_containerengine_node_pool" "k8s_node_pool" {
  cluster_id         = oci_containerengine_cluster.k8s_cluster.id
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version
  name               = "k8s-node-pool"

  node_metadata = {
    user_data = base64encode(file("files/node-pool-init.sh"))
  }

  node_config_details {
    placement_configs {
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
      subnet_id           = oci_core_subnet.vcn_private_subnet.id
    }
    defined_tags = {
      "k8s-node-pool.role" = "worker"
    }

    placement_configs {
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
      subnet_id           = oci_core_subnet.vcn_private_subnet.id
    }

    placement_configs {
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[2].name
      subnet_id           = oci_core_subnet.vcn_private_subnet.id
    }

    size = var.kubernetes_worker_nodes
  }

  node_shape = "VM.Standard.A1.Flex"

  node_shape_config {
    memory_in_gbs = 12
    ocpus         = 2
  }
  node_source_details {
    image_id    = jsondecode(data.jq_query.latest_image.result)
    source_type = "image"

    boot_volume_size_in_gbs = 50
  }
  initial_node_labels {
    key   = "name"
    value = "k8s-cluster"
  }
  ssh_public_key = var.ssh_public_key
}

resource "oci_identity_dynamic_group" "k8s_nodes" {
  compartment_id = var.compartment_id  # Dynamic groups must be created at tenancy level
  name           = "k8s-nodes"
  description    = "Dynamic group for OKE worker nodes"
  matching_rule  = "tag.k8s-node-pool.role.value = 'worker'"
}

resource "oci_identity_policy" "k8s_nodes_object_storage" {
  compartment_id = var.compartment_id
  name           = "k8s-nodes-object-storage"
  description    = "Allow k8s nodes to access Object Storage"
  statements = [
    "Allow dynamic-group k8s-nodes to manage objects in compartment id ${var.compartment_id} where target.bucket.name = 'minecraft-backups'",
  ]
}

