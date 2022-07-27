/**
 * Lambda config map
 */

output "lambda_configmap" {
  description = "This sets the configuration for lambdas deployed in this repo"
  value = {
    "${local.callback_lambda_name}" = {
      image_uri          = "${local.ecr_path}/${local.callback_lambda_name}:a5f9c5c.93"
      lambda_handler     = null
      lambda_description = "Lambda"
      package_type       = "Image"
      timeout            = 60
      memory_size        = 512
      environment_variables = {
        "DBSecretARN" : "${local.property_data_orchestration_secret}",
        "SlackChannel" : "${local.slack_channel}"
      }
      vpc_id = local.lambda_vpc_id,
      aws_lambda_permission = [
        "ec2.amazonaws.com"
      ]
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
        "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      ],
      lambda_inline_policy = <<-EOF
      {
          "Version": "2012-10-17",
          "Statement": [
              {
              "Effect": "Allow",
              "Action": [
                  "ec2:DescribeInstances",
                  "ec2:DescribeInstanceStatus",
                  "ec2:DeleteTags",
                  "ec2:CreateTags",
                  "ecr:*",
                  "secretsmanager:*",
                  "s3:*",
                  "lambda:*",
                  "states:*"
              ],
              "Resource": "*"
              }
          ]
      }
      EOF
    },
    "${local.legacyupdate_lambda_name}" = {
      image_uri          = "${local.ecr_path}/${local.legacyupdate_lambda_name}:e0bae8f.88"
      vpc_id             = local.lambda_vpc_id,
      lambda_handler     = null
      lambda_description = "Lambda"
      package_type       = "Image"
      timeout            = 60
      memory_size        = 512
      environment_variables = {
        LEGACY_ENDPOINT : "${local.legacy_endpoint}",
        LEGACY_AUTH_SECRET : "${local.property_data_orchestration_secret}"
      }
      aws_lambda_permission = [
        "ec2.amazonaws.com"
      ]
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
        "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      ],
      lambda_inline_policy = <<-EOF
      {
          "Version": "2012-10-17",
          "Statement": [
              {
              "Effect": "Allow",
              "Action": [
                  "ec2:DescribeInstances",
                  "ec2:DescribeInstanceStatus",
                  "ec2:DeleteTags",
                  "ec2:CreateTags",
                  "ecr:*",
                  "secretsmanager:*",
                  "s3:*",
                  "lambda:*",
                  "states:*"
              ],
              "Resource": "*"
              }
          ]
      }
      EOF
    },
    "${local.callout_lambda_name}" = {
      image_uri          = "${local.ecr_path}/${local.callout_lambda_name}:173f51b.42"
      lambda_handler     = null
      lambda_description = "Lambda"
      package_type       = "Image"
      timeout            = 60
      memory_size        = 512
      environment_variables = {
        "DBSecretARN" : "${local.property_data_orchestration_secret}",
        "envLegacyUpdatefunction" : "arn:aws:lambda:${local.region}:${local.account_id}:function:${local.resource_name_prefix}-lambda-${local.legacyupdate_lambda_name}",
        "envCallbackLambdaFunction" : "arn:aws:lambda:${local.region}:${local.account_id}:function:${local.resource_name_prefix}-lambda-${local.callback_lambda_name}",
        "SlackChannel" : "${local.slack_channel}"
      }
      vpc_id = local.lambda_vpc_id,
      aws_lambda_permission = [
        "ec2.amazonaws.com"
      ]
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
        "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      ],
      lambda_assume_role_policy = <<-EOF
        {
          "Version": "2012-10-17",
          "Statement": [
              {
                  "Effect": "Allow",
                  "Principal": {
                      "Service": "lambda.amazonaws.com"
                  },
                  "Action": "sts:AssumeRole"
              },
              {
                  "Effect": "Allow",
                  "Principal": {
                      "Federated": "arn:aws:iam::${local.account_id}:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/${local.eks_cluster_id}"
                  },
                  "Action": "sts:AssumeRoleWithWebIdentity",
                  "Condition": {
                      "StringEquals": {
                          "oidc.eks.us-east-2.amazonaws.com/id/${local.eks_cluster_id}:sub": "system:serviceaccount:factory-dx-human-extraction:hipster-api-service-account",
                          "oidc.eks.us-east-2.amazonaws.com/id/${local.eks_cluster_id}:aud": "sts.amazonaws.com"
                      }
                  }
              },
              {
                  "Effect": "Allow",
                  "Principal": {
                      "Federated": "arn:aws:iam::${local.account_id}:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/${local.eks_cluster_id}"
                  },
                  "Action": "sts:AssumeRoleWithWebIdentity",
                  "Condition": {
                      "StringEquals": {
                          "oidc.eks.us-east-2.amazonaws.com/id/${local.eks_cluster_id}:sub": "system:serviceaccount:factory-dx-human-extraction:pmf-conversion-service-account",
                          "oidc.eks.us-east-2.amazonaws.com/id/${local.eks_cluster_id}:aud": "sts.amazonaws.com"
                      }
                  }
              }
          ]
        }
      EOF
      lambda_inline_policy = <<-EOF
      {
          "Version": "2012-10-17",
          "Statement": [
              {
              "Effect": "Allow",
              "Action": [
                  "ec2:DescribeInstances",
                  "ec2:DescribeInstanceStatus",
                  "ec2:DeleteTags",
                  "ec2:CreateTags",
                  "ecr:*",
                  "secretsmanager:*",
                  "s3:*",
                  "lambda:*",
                  "states:*"
              ],
              "Resource": "*"
              }
          ]
      }
      EOF

      lambda_assume_role_policy = <<-EOF
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Action": "sts:AssumeRole",
            "Principal": {
              "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow"
          },
          {
            "Effect": "Allow",
            "Principal": {
              "Federated": "arn:aws:iam::${local.account_id}:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/${local.eks_cluster_id}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
              "StringEquals": {
                "oidc.eks.us-east-2.amazonaws.com/id/${local.eks_cluster_id}:aud": "sts.amazonaws.com",
                "oidc.eks.us-east-2.amazonaws.com/id/${local.eks_cluster_id}:sub": "system:serviceaccount:factory-dx-human-extraction:hipster-api-service-account"
              }
            }
          }
        ]
      }
      EOF

    },
    "${local.datastore_lambda_name}" = {
      image_uri          = "${local.ecr_path}/${local.datastore_lambda_name}:783c021.7"
      vpc_id             = local.lambda_vpc_id,
      lambda_handler     = null
      lambda_description = "Lambda"
      package_type       = "Image"
      timeout            = 60
      memory_size        = 512
      environment_variables = {
        "DBSecretARN" : "${local.property_data_orchestration_secret}",
        "SlackChannel" : "${local.slack_channel}"
      }
      aws_lambda_permission = [
        "ec2.amazonaws.com"
      ]
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
        "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      ],
      lambda_inline_policy = <<-EOF
      {
          "Version": "2012-10-17",
          "Statement": [
              {
              "Effect": "Allow",
              "Action": [
                  "ec2:DescribeInstances",
                  "ec2:DescribeInstanceStatus",
                  "ec2:DeleteTags",
                  "ec2:CreateTags",
                  "ecr:*",
                  "secretsmanager:*",
                  "s3:*",
                  "lambda:*",
                  "states:*"
              ],
              "Resource": "*"
              }
          ]
      }
      EOF
    },
    "${local.throttleservice_lambda_name}" = {
      image_uri          = "${local.ecr_path}/${local.throttleservice_lambda_name}:e0bae8f.92"
      vpc_id             = local.lambda_vpc_id,
      lambda_handler     = null
      lambda_description = "Lambda"
      package_type       = "Image"
      timeout            = 60
      memory_size        = 512
      environment_variables = {
        "DBSecretARN" : "${local.property_data_orchestration_secret}",
        "SlackChannel" : "${local.slack_channel}",
        "AllowedHipsterCount" : 50
      }
      aws_lambda_permission = [
        "ec2.amazonaws.com"
      ]
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
        "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      ],
      lambda_inline_policy = <<-EOF
      {
          "Version": "2012-10-17",
          "Statement": [
              {
              "Effect": "Allow",
              "Action": [
                  "ec2:DescribeInstances",
                  "ec2:DescribeInstanceStatus",
                  "ec2:DeleteTags",
                  "ec2:CreateTags",
                  "ecr:*",
                  "secretsmanager:*",
                  "s3:*",
                  "lambda:*",
                  "states:*"
              ],
              "Resource": "*"
              }
          ]
      }
      EOF
    },

    "${local.evmlconveter_lambda_name}" = {
      image_uri          = "${local.ecr_path}/${local.evmlconveter_lambda_name}:e0bae8f.91"
      lambda_handler     = null
      lambda_description = "Lambda"
      package_type       = "Image"
      timeout            = 60
      memory_size        = 512
      environment_variables = {
        "DBSecretARN" : "${local.property_data_orchestration_secret}",
        "envEvJsonConvertorEndpoint" : "${local.ev_json_convertor_endpoint}",
        "envCalloutLambdaFunction" : "arn:aws:lambda:${local.region}:${local.account_id}:function:${local.resource_name_prefix}-lambda-${local.callout_lambda_name}",
        "envLegacyEndpoint" : "${local.legacy_endpoint}",
        "SlackChannel" : "${local.slack_channel}"
      }
      vpc_id = local.lambda_vpc_id,
      aws_lambda_permission = [
        "ec2.amazonaws.com"
      ]
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
        "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      ],
      lambda_inline_policy = <<-EOF
      {
          "Version": "2012-10-17",
          "Statement": [
              {
              "Effect": "Allow",
              "Action": [
                  "ec2:DescribeInstances",
                  "ec2:DescribeInstanceStatus",
                  "ec2:DeleteTags",
                  "ec2:CreateTags",
                  "ecr:*",
                  "secretsmanager:*",
                  "s3:*",
                  "lambda:*",
                  "states:*"
              ],
              "Resource": "*"
              }
          ]
      }
      EOF
    },
     "${local.uploadimage_lambda_name}" = {
      image_uri          = "${local.ecr_path}/${local.evmlconveter_lambda_name}:e0bae8f.91"
      lambda_handler     = null
      lambda_description = "Lambda"
      package_type       = "Image"
      timeout            = 60
      memory_size        = 512
      environment_variables = {
        "SlackChannel" : "${local.slack_channel}",
        "LEGACY_ENDPOINT":"${local.endpoint_url_legacy}",
        "SlackChannel" : "${local.slack_channel}"
      }
      vpc_id = local.lambda_vpc_id,
      aws_lambda_permission = [
        "ec2.amazonaws.com"
      ]
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
        "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      ],
      lambda_inline_policy = <<-EOF
      {
          "Version": "2012-10-17",
          "Statement": [
              {
              "Effect": "Allow",
              "Action": [
                  "ec2:DescribeInstances",
                  "ec2:DescribeInstanceStatus",
                  "ec2:DeleteTags",
                  "ec2:CreateTags",
                  "ecr:*",
                  "secretsmanager:*",
                  "s3:*",
                  "lambda:*",
                  "states:*"
              ],
              "Resource": "*"
              }
          ]
      }
      EOF
    }
  }
}

output "sfn_lambda_configmap" {
  description = "This sets the configuration for lambdas deployed in this repo"
  value = {

    "${local.invokesfn_lambda_name}" = {
      image_uri          = "${local.ecr_path}/${local.invokesfn_lambda_name}:e0bae8f.89"
      vpc_id             = local.lambda_vpc_id,
      lambda_handler     = null
      lambda_description = "Lambda"
      package_type       = "Image"
      timeout            = 60
      memory_size        = 512
      environment_variables = {
        "StateMachineARN" : "arn:aws:states:${local.region}:${local.account_id}:stateMachine:${local.resource_name_prefix}-sfn-${local.symphony_workflow_name}",
        "SlackChannel" : "${local.slack_channel}",
        "DBSecretARN" : "${local.property_data_orchestration_secret}"
      }
      aws_lambda_permission = [
        "ec2.amazonaws.com"
      ]
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
        "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      ],
      lambda_inline_policy = <<-EOF
      {
          "Version": "2012-10-17",
          "Statement": [
              {
                "Effect": "Allow",
                "Action": [
                    "ec2:DescribeInstances",
                    "ec2:DescribeInstanceStatus",
                    "ec2:DeleteTags",
                    "ec2:CreateTags",
                    "ecr:*",
                    "secretsmanager:*",
                  "s3:*",
                  "lambda:*",
                  "states:*"
                ],
                "Resource": "*"
              },
              {
                "Effect": "Allow",
                "Action": [
                  "sqs:DeleteMessage",
                  "sqs:ReceiveMessage",
                  "sqs:GetQueueAttributes"
                ],
                "Resource": "arn:aws:sqs:${local.region}:${local.account_id}:${local.resource_name_prefix}-sqs-${local.receive_legacy_order_queue_name}"
              }
              
          ]
      }
      EOF
    }
  }
}

