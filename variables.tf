# ==========================================
# vSphere Components
# ==========================================
variable "vsphere_user" {
  type = string
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}

variable "vsphere_server" {
  type = string
}

variable "vsphere_datacenter" {
  type = string
}

variable "vsphere_datastore" {
  type = string
}

variable "vsphere_cluster" {
  type = string
}

variable "vsphere_network" {
  type = string
}

variable "vsphere_template" {
  type = string
}

# ==========================================
# Kubernetes VM Specs (Control Plane)
# ==========================================
variable "master_count" {
  type = number
}

variable "master_cpu" {
  type = number
}

variable "master_memory" {
  type = number
}

variable "master_ips" {
  type = list(string)
}

# ==========================================
# Kubernetes VM Specs (Worker Plane)
# ==========================================
variable "worker_count" {
  type = number
}

variable "worker_cpu" {
  type = number
}

variable "worker_memory" {
  type = number
}

variable "worker_ips" {
  type = list(string)
}

# ==========================================
# Kubernetes Network Configuration
# ==========================================
variable "domain_name" {
  type = string
}

variable "network_gateway" {
  type = string
}

variable "network_netmask" {
  type = number
}

variable "dns_server" {
  type = list(string)
}