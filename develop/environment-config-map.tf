/**
 * Environment config map
 */

output "environment_config_map" {
  description = "Contains the configuration map for environment variables"
  value = {

    // Region where the resources will be deployed
    region = local.region,

    // This is the deployment version
    deployment_version = local.deployment_version,

    // Environment where the resources will be deployed
    environment = local.environment,

    // EVTech program
    evtech_program = local.evtech_program,

    // EVtech owner tag
    evtech_owner = local.evtech_owner,

    // All resources will be prefixed with this.
    resource_name_prefix = local.resource_name_prefix,

    // AWS account id
    account_id = local.account_id,

    // ID of the VPC where the lambda will be deployed.
    // TODO: Needs to be extracted from SSM
    vpc_id = local.lambda_vpc_id,

    // Name of the invokesfn lambda function
    invokesfn_lambda_name = local.invokesfn_lambda_name,

    // Name of the legacy order queue
    receive_legacy_order_queue_name = local.receive_legacy_order_queue_name

    // Name of the SIM order queue
    receive_sim_order_queue_name = local.receive_sim_order_queue_name

    // Name of the DocumentDB Secret Manager
    property_data_orchestration_secret = local.property_data_orchestration_secret

    // Name of the callback lambda
    callback_lambda_name = local.callback_lambda_name

    // ARN for the EV-Factory account role that access the callback lambda
    cross_account_callback_lambda = "arn:aws:iam::${local.evtech_factory_account}:role/measurement-service-dev-callback-lambda-role"

    // trust relationship value for external services like hipster/MA/EV_json converter
    trust_relashionships_external_service = <<EOT
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
    EOT

    sns_domain_event_subscription_legacy_sqs = <<EOF
{
        "company": [
          "Eagleview"
        ],
        "event": [
          "sfn_measurement_automation_workflow",
          "sfn_automated_image_selection_workflow"
        ],
        "domain": [
          "sfn_measurement_automation"
        ]
      }
      EOF
    
  }
}
