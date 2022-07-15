variable "ami_id" {
  default = "ami-0cff7528ff583bf9a"

}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "key_name" {
  default = "jun2022"
}

#  "ami-0cff7528ff583bf9a"
# ami-0d9858aa3c6322f73