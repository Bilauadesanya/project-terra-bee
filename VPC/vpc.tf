resource "aws_vpc" "bee-vpc" {
  cidr_block = var.Vpc_cidr
  #tags = var.tags

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-vpc"
  })


}
resource "aws_subnet" "public-subnet1" {
  vpc_id     = aws_vpc.bee-vpc.id
  cidr_block = var.public_subnet1_cidr_block
  availability_zone = var.availability_zone-1[0]
  map_public_ip_on_launch = true
  #tags = var.tags

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public-subnet1"
  })
}
resource "aws_subnet" "public-subnet2" {
  vpc_id     = aws_vpc.bee-vpc.id
  cidr_block = var.public_subnet2_cidr_block
  availability_zone = var.availability_zone-1[1]
  map_public_ip_on_launch = true
  #tags = var.tags

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public-subnet2"
  })
}
resource "aws_subnet" "private-subnet1" {
  vpc_id     = aws_vpc.bee-vpc.id
  cidr_block = var.private_subnet1_cidr_block
  availability_zone = var.availability_zone-1[0]
 
 tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-subnet1"
  })
 
  #tags = var.tags
}
resource "aws_subnet" "private-subnet2" {
  vpc_id     = aws_vpc.bee-vpc.id
  cidr_block = var.private_subnet2_cidr_block
  availability_zone = var.availability_zone-1[1]
  #tags = var.tags


  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-subnet2"
  })
}


resource "aws_internet_gateway" "GateWay" {
    vpc_id = aws_vpc.bee-vpc.id

     tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-IGW"
  })
}


resource "aws_eip" "Nat-eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.Nat-eip.id
  subnet_id     = aws_subnet.public-subnet1.id

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-Nat_gw"
  })
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_eip.Nat-eip, aws_subnet.public-subnet1]
}
resource "aws_route_table" "Public_RT" {
  vpc_id = aws_vpc.bee-vpc.id

  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.GateWay.id
    }


     tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-Public_RT"
  })
}

resource "aws_route_table_association" "Public_RT_Association" {
  subnet_id = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.Public_RT.id
}
resource "aws_route_table_association" "Public_RT_Association2" {
  subnet_id = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.Public_RT.id
}
resource "aws_route_table_association" "Private_RT_Association" {
  subnet_id = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.Private_RT.id
}
resource "aws_route_table_association" "Private_RT_Association2" {
  subnet_id = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.Private_RT.id
}
resource "aws_route_table" "Private_RT" {
  vpc_id = aws_vpc.bee-vpc.id

  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw.id
    }


     tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-Private_RT"
  })
}