/**
 * SQS config map
 */

output "sqs_config_map" {
  description = "This sets the configuration for SQS deployed in this repo"
  value = {
    "${local.receive_legacy_order_queue_name}" = {
      delay_seconds              = 0
      max_message_size           = 2048
      message_retention_seconds  = 1209600
      receive_wait_time_seconds  = 0,
      visibility_timeout_seconds = 60
      sse                        = true
      policy                     = <<-EOF
        {
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "__owner_statement",
      "Effect": "Allow",
      "Principal": {
        "AWS": [  
         "arn:aws:iam::${local.legacy_report_account}:role/EC2SSMRole",
          "arn:aws:iam::${local.account_id}:root"  
        ],
        "Service": "sns.amazonaws.com"
      },
      "Action": "SQS:*",
      "Resource": "arn:aws:sqs:${local.region}:${local.account_id}:${local.resource_name_prefix}-sqs-${local.receive_legacy_order_queue_name}"
    }
  ]
}
EOF
    },
    "${local.receive_sim_order_queue_name}" = {
      delay_seconds              = 0
      max_message_size           = 2048
      message_retention_seconds  = 1209600
      receive_wait_time_seconds  = 0,
      visibility_timeout_seconds = 60
      sse                        = true
      policy                     = <<-EOF
        {
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "__owner_statement",
      "Effect": "Allow",
      "Principal": {
        "AWS": [  
          "arn:aws:iam::${local.account_id}:root"
        ],
        "Service": "sns.amazonaws.com"
      },
      "Action": "SQS:*",
      "Resource": "arn:aws:sqs:${local.region}:${local.account_id}:${local.resource_name_prefix}-sqs-${local.receive_sim_order_queue_name}"
    },
    {
     "Effect": "Allow",
     "Principal": {
         "Federated": "arn:aws:iam::356071200662:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/E09EAD6977269F0D71AB62C95222F0AF"
     },
     "Action": "sts:AssumeRoleWithWebIdentity",
     "Condition": {
         "StringEquals": {
             "oidc.eks.us-east-2.amazonaws.com/id/E09EAD6977269F0D71AB62C95222F0AF:sub": "system:serviceaccount:factory-dx-reports-workflow:factory-dx-reports-workflow-service-account",
             "oidc.eks.us-east-2.amazonaws.com/id/E09EAD6977269F0D71AB62C95222F0AF:aud": "sts.amazonaws.com"
         }
    }
  
  ]
}
EOF
    }
  }
}
