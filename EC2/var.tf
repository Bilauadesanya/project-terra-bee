variable "ami" {
    type = string
    description = "(optional) describe your variable"
    default = "ami-05c13eab67c5d8861"
}
variable "instance_type" {
    type = string
    description = "(optional) describe your variable"
    default = "t2.micro"
}
variable "tags" {
  type = map(string)
  description = "tags"

}
variable "subnet_id" {
    type = string
    description = "(optional) describe your variable"
}

variable "vpc_id" {
    type = string
    description = "(optional) describe your variable"
}

# variable "vpc_cidr" {
#     type = string
#     description = "(optional) describe your variable"
# }