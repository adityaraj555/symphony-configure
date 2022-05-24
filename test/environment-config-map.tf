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

    //Name of the DocumentDB Secret Manager
    property_data_orchestration_secret = local.property_data_orchestration_secret

    // Name of the callback lambda
    callback_lambda_name = local.callback_lambda_name

    // ARN for the EV-Factory account role that access the callback lambda
    cross_account_callback_lambda = "arn:aws:iam::366384665027:role/measurement-service-lambda-LambdaExecutionRole-2JESM57HC4J4"

  }
}
