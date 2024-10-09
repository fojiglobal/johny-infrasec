##########################################################################
############# Staging infra provisioning using custum module
##########################################################################

module "staging" {
  source                               = "./modules"
  vpc_cidr                             = local.vpc_cidr
  env                                  = local.env
  provisioner                          = local.provisioner
  public_subnets                       = local.public-subnets
  private_subnets                      = local.private-subnets
  public_subnet_name                   = local.public_subnet_name
  public_sg_ingress                    = local.public_sg_ingress
  public_sg_egress                     = local.public_sg_egress
  private_sg_ingress                   = local.private_sg_ingress
  private_sg_egress                    = local.private_sg_egress
  bastion_sg_ingress                   = local.bastion_sg_ingress
  bastion_sg_egress                    = local.bastion_sg_egress
  all_ipv4_cidr                        = local.all_ipv4_cidr
  image_id                             = local.image_id
  instance_initiated_shutdown_behavior = local.instance_initiated_shutdown_behavior
  instance_type                        = local.instance_type
  key_pairs_name                       = local.key_pairs_name
  resource_type                        = local.resource_type
  user_data                            = local.user_data
  lb_proto_http = local.lb_proto_http
  load_balancer_type = local.load_balancer_type
  lb_proto_https = local.lb_proto_https
  lb_port_http = local.lb_port_http
  lb_port_https = local.lb_port_https
  lb_ssl_policy = local.lb_ssl_policy
  zone_id = local.zone_id
  certificate_arn = local.certificate_arn
  dns_aliases = local.dns_aliases
  desired_capacity    = local.desired_capacity
  max_size            = local.max_size
  min_size            = local.min_size
  health_check_grace_period = local.health_check_grace_period
  health_check_type         = local.health_check_type
}