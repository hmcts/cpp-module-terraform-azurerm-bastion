variable "private_only_enabled" {
  type        = bool
  default     = true
  description = "Enable private-only Bastion (default: true)"
}

variable "location" {
  type = string
}

variable "parent_id" {
  type = string
}

variable "zones" {
  type        = set(string)
  default     = ["1", "2", "3"]
  description = "The availability zones where the Azure Bastion Host is deployed."
}

variable "copy_paste_enabled" {
  type = string
}

variable "file_copy_enabled" {
  type = string
}

variable "ip_connect_enabled" {
  type = string
}

variable "kerberos_enabled" {
  type = string
}

variable "session_recording_enabled" {
  type = string
}

variable "shareable_link_enabled" {
  type = string
}

variable "tunneling_enabled" {
  type = string
}

variable "ip_configuration" {
  type = map(any)
}

variable "sku" {
  type    = string
  default = "Standard"
}
variable "name" {
  type = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}