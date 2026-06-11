#create network ACL for second public and private subnet



resource "aws_network_acl" "public_nacl1" {
    vpc_id = var.tier2_vpc
    #edit rules as needed
   # subnet_ids = [var.public_subnet] # Associate with the subnet

  # Inbound rule: Allow SSH from anywhere (rule 100)
  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0" #allow SSH from anywhere
    from_port  = 22
    to_port    = 22
  }
  ingress {
    rule_no    = 110
    action     = "allow"
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0" #if you want to allow from anywhere
    from_port  = 80
    to_port    = 80
  }
  ingress {
    rule_no    = 120
    action     = "allow"
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0" #if you want to allow from anywhere
    from_port  = 443
    to_port    = 443
  }
  ingress {
    rule_no    = 130
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0" #if you want to allow from anywhere
    from_port  = 0
    to_port    = 0
  }

  # Outbound rule: Allow all outbound traffic (rule 100)
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.0.0/16" # send traffic to local VPC
    from_port  = 0
    to_port    = 0
  }
  egress {
    rule_no    = 110
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "public_nacl1"
  }
}
#=========================================================================
#associate network ACL with first public subnet
resource "aws_network_acl_association" "nacl1_public_assoc" {
    subnet_id = var.public_subnet
    network_acl_id = aws_network_acl.public_nacl1.id
}
resource "aws_network_acl_association" "nacl2_public_assoc" {
  subnet_id = var.public_subnet2
  network_acl_id = aws_network_acl.public_nacl1.id
}


#=========================================================================
#network ACL for private subnet
resource "aws_network_acl" "private_nacl1" {
    vpc_id = var.tier2_vpc
    #edit rules as needed
   # subnet_ids = [var.private_subnet] # Associate with the subnet
   # Inbound rule: Allow all traffic from within the VPC CIDR (rule 100)
    ingress {
        rule_no    = 100
        action     = "allow"
        protocol   = "tcp"
        cidr_block = var.vpc_cidr_block #if you want to allow from VPC only
        from_port  = 22
        to_port    = 22
        }
    ingress {
        rule_no    = 110
        action     = "allow"
        protocol   = "tcp"
        cidr_block = var.vpc_cidr_block #if you want to allow from VPC only
        from_port  = 3306 #test mysql access within VPC
        to_port    = 3306
    }

    egress {
        rule_no    = 100
        action     = "allow"
        protocol   = "-1"
        cidr_block = var.vpc_cidr_block
        from_port  = 0
        to_port    = 0      
    }
    tags = {
      "Name" = "private_nacl1" 
      }
}

#associate network ACL with first private subnet
resource "aws_network_acl_association" "nacl1_private_assoc" {
    subnet_id = var.private_subnet
    network_acl_id = aws_network_acl.private_nacl1.id
}
resource "aws_network_acl_association" "nacl2_private_assoc" {
  subnet_id = var.private_subnet2
  network_acl_id = aws_network_acl.private_nacl1.id
}
