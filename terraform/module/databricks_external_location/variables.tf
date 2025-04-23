variable "name" {
  type = string
}

variable "url" {
  type = string
}

variable "credential_name" {
  type = string
}

variable "comment" {
  type    = string
  default = ""
}

variable "depends_on" {
  type    = list(any)
  default = []
}
