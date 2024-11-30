##########################################################################
############# Locals for VPC
##########################################################################

locals {
  use2a = "us-east-2"

  # aws_org_unit = {
  #   "sandbox" = {
  #     name = "sandbox"
  #   }
  #   "security" = {
  #     name = "security"
  #   }
  # }

  # aws_account = {
  #   "cs2-sandbox" = {
  #     name  = "cs2-sandbox"
  #     email = "cs2.johnysandbox@gmail.com"
  #   }
  #   "cs2-security" = {
  #     name  = "cs2-security"
  #     email = "cs2.johnysec@gmail.com"
  #   }
  # }
}

# variable "aws_account" {
#   type = map(object({
#     name  = string
#     email = string
#   }))
# }

# variable "aws_org_unit" {
#   type = map(object({
#     name = string
#   }))
# }