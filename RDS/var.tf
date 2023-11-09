variable "tags" {
  type = map(string)
  description = "tags"

}
variable "private_subnet1" {
    type = string
    description = "id of subnet"

}

variable "private_subnet2" {
    type = string
    description = "id of subnet"

}
variable "vpc_id" {
    type = string
    description = "(optional) describe your variable"
}
variable "vpc_cidr" {
    type = string
    description = "(optional) describe your variable"
}