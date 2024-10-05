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
}