########################################################################################
################# Import the AWS Organization created from the console #################
########################################################################################

import {
  to = aws_organizations_organization.org
  id = "o-dzm7blt0tz"
}

########################################################################################
######### Import the AWS Sandbox and Security Account created from the console #########
########################################################################################

import {
  to = aws_organizations_account.cs2_sandbox
  id = "863518440945"
}

import {
  to = aws_organizations_account.cs2_security
  id = "976193246014"
}

########################################################################################
####################### Import the AWS OU created from the console #####################
########################################################################################

import {
  to = aws_organizations_organizational_unit.sandbox
  id = "ou-c7d3-gm1l41qr"
}

import {
  to = aws_organizations_organizational_unit.security
  id = "ou-c7d3-9bq9clfu"
}