variable "Engineer" {
  type    = string
  default = "Erwin"
}

variable "availability_zone" {
  type    = list(string)
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "public_cidr" {
  type    = list(string)
  default = ["10.69.34.0/24", "10.69.35.0/24"]
}

variable "private_cidr" {
  type    = list(string)
  default = ["10.69.10.0/24", "10.69.20.0/24"]
}
