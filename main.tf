resource "aws_ec2_client_vpn_endpoint" "client-vpn-ep" {
  description            = "terraform-clientvpn-endpoint"
  server_certificate_arn = var.server_certificate_arn
  client_cidr_block      = var.client_cidr_block_address

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.root_certificate_chain_arn
  }
  
  connection_log_options {
    enabled               = false
  }
  split_tunnel = true
  vpc_id = var.vpc_id
  
}

resource "aws_ec2_client_vpn_network_association" "example-na-1" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client-vpn-ep.id
  subnet_id              = var.assoc_subnet_id_1
}

resource "aws_ec2_client_vpn_network_association" "example-na-2" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client-vpn-ep.id
  subnet_id              = var.assoc_subnet_id_2
}


resource "aws_ec2_client_vpn_authorization_rule" "example-ingress" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client-vpn-ep.id
  target_network_cidr    = var.target_network_cidr
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_route" "example-rtb-1" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client-vpn-ep.id
  destination_cidr_block = "10.0.0.0/16"
  target_vpc_subnet_id   = "subnet-0a007b904b5e35448"
}

resource "aws_ec2_client_vpn_route" "example-rtb-2" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client-vpn-ep.id
  destination_cidr_block = "10.0.0.0/16"
  target_vpc_subnet_id   = "subnet-0bd47fe206beaa3ac"
}
