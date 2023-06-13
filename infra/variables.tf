variable "activate_apis" {
  description = "Service APIs to enable."
  type        = list(string)
  default     = ["compute.googleapis.com", "dns.googleapis.com", "container.googleapis.com"]
}

variable "owners" {
  description = "Optional list of IAM-format members to set as project owners."
  type        = list(string)
  default     = []
}





