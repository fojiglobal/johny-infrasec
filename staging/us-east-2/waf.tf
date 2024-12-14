#### Web ACL to protect our app in the staging environment

resource "aws_wafv2_web_acl" "staging_web_acl" {
  name        = "${local.env}-waf"
  description = "WebACL to protect Load Balancer using free AWS Managed Rules"
  scope       = "REGIONAL"

  # Default web ACL action for requests that don't match any rules
  default_action {
    allow {}
  }

  rule {
    name     = "AWSManagedRulesAdminProtectionRuleSet"
    priority = 1
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAdminProtectionRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled    = true
      cloudwatch_metrics_enabled  = true
      metric_name                 = "AWSManagedRulesAdminProtectionRuleSet"
    }
  }

  rule {
    name     = "AWSManagedRulesAmazonIpReputationList"
    priority = 2
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled    = true
      cloudwatch_metrics_enabled  = true
      metric_name                 = "AWSManagedRulesAmazonIpReputationList"
    }
  }

  rule {
    name     = "AWSManagedRulesAnonymousIpList"
    priority = 3
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled    = true
      cloudwatch_metrics_enabled  = true
      metric_name                 = "AWSManagedRulesAnonymousIpList"
    }
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 4
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled    = true
      cloudwatch_metrics_enabled  = true
      metric_name                 = "AWSManagedRulesCommonRuleSet"
    }
  }

  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 5
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled    = true
      cloudwatch_metrics_enabled  = true
      metric_name                 = "AWSManagedRulesKnownBadInputsRuleSet"
    }
  }

  rule {
    name     = "AWSManagedRulesLinuxRuleSet"
    priority = 6
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled    = true
      cloudwatch_metrics_enabled  = true
      metric_name                 = "AWSManagedRulesLinuxRuleSet"
    }
  }

  rule {
    name     = "AWSManagedRulesPHPRuleSet"
    priority = 7
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesPHPRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled    = true
      cloudwatch_metrics_enabled  = true
      metric_name                 = "AWSManagedRulesPHPRuleSet"
    }
  }

  rule {
    name     = "AWSManagedRulesPOSIXRuleSet"
    priority = 8
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesPOSIXRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled    = true
      cloudwatch_metrics_enabled  = true
      metric_name                 = "AWSManagedRulesPOSIXRuleSet"
    }
  }

  rule {
    name     = "AWSManagedRulesSQLiRuleSet"
    priority = 9
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled    = true
      cloudwatch_metrics_enabled  = true
      metric_name                 = "AWSManagedRulesSQLiRuleSet"
    }
  }

  rule {
    name     = "AWSManagedRulesWindowsRuleSet"
    priority = 10
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesWindowsRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled    = true
      cloudwatch_metrics_enabled  = true
      metric_name                 = "AWSManagedRulesWindowsRuleSet"
    }
  }

  rule {
    name     = "AWSManagedRulesWordPressRuleSet"
    priority = 11
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesWordPressRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled    = true
      cloudwatch_metrics_enabled  = true
      metric_name                 = "AWSManagedRulesWordPressRuleSet"
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${local.env}-web-acl"
    sampled_requests_enabled   = true
  }
}

# Web ACL association with the Application Load Balancer we want to protect

resource "aws_wafv2_web_acl_association" "staging_association" {
  resource_arn = module.staging.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.staging_web_acl.arn
}