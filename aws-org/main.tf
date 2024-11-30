########################################################################################
######################### Create and Enable the AWS Organization #######################
########################################################################################

resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set = "ALL"
}

########################################################################################
########################## Create two AWS Organization Units ###########################
########################################################################################

# resource "aws_organizations_organizational_unit" "aws_org_unit" {
#   for_each  = local.aws_org_unit
#   name      = each.value[name]
#   parent_id = aws_organizations_organization.org.roots[0].id
# }

resource "aws_organizations_organizational_unit" "sandbox" {
  name      = "sandbox"
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "security" {
  name      = "security"
  parent_id = aws_organizations_organization.org.roots[0].id
}

########################################################################################
######################## Create two AWS Organization Accounts ###########################
########################################################################################

# resource "aws_organizations_account" "account" {
#   for_each  = local.aws_account
#   name      = each.value[name]
#   email     = each.value[email]
#   parent_id = aws_organizations_organizational_unit.aws_org_unit[each.key].id
# }

resource "aws_organizations_account" "cs2_sandbox" {
  name      = "cs2-sandbox"
  email     = "cs2.johnysand@gmail.com"
  parent_id = aws_organizations_organizational_unit.sandbox.id
}

resource "aws_organizations_account" "cs2_security" {
  name      = "cs2-security"
  email     = "cs2.johnysec@gmail.com"
  parent_id = aws_organizations_organizational_unit.security.id
}