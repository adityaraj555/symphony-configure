locals {
  // Environment where the resources will be deployed
  environment = "prod"

  stack_level = var.build_number == "" ? "app" : "tb-${var.build_number}"

  // The deployment version included as part of the resource name prefixes
  // Deployment version can be used to provision multiple versions of the infrastructure at the same time
  deployment_version = "1x0"

  resource_name_prefix = "${local.stack_level}-${local.environment}-${local.deployment_version}"

  // Region where the resources will be deployed
  region = "us-east-2"

  // Program tag
  evtech_program = "property-data-orchestrator"

  // Owner tag
  evtech_owner = "mustangs@eagleview.com"

  // Name of the callback lambda function
  callback_lambda_name = "callbacklambda"

  // Name of the callout lambda function
  callout_lambda_name = "calloutlambda"

  // Name of the datastore lambda function
  datastore_lambda_name = "datastorelambda"

  // Name of the legacyupdate lambda function
  legacyupdate_lambda_name = "legacyupdate"

  // Name of the invokesfn lambda function
  invokesfn_lambda_name = "invokesfn"

  // name of the throttleservice lambda function
  throttleservice_lambda_name = "throttleservice"

  // Name of the evmlconverter lambda function
  evmlconveter_lambda_name = "evmlconverter"

  // Name of the symphony workflow
  symphony_workflow_name = "symphony_workflow"

  // Name of the symphony workflow
  receive_legacy_order_queue_name = "receiveLegacyOrder"

  // Account id
  account_id = "249106962406"

  // ECR PATH.
  ecr_path = "176992832580.dkr.ecr.${local.region}.amazonaws.com/property-data-orchestrator"

  // VPC where lambdas will be installed
  lambda_vpc_id = "vpc-09d95204cb5271921"

  // slack channel to send error notifications
  slack_channel = "C03G9F8KDTJ"

  // secret manager ARN
  property_data_orchestration_secret = "arn:aws:secretsmanager:us-east-2:${local.account_id}:secret:property-data-orchestrator-secret-SfXCVm"

  endpoint_url_legacy = "https://intranetrest.cmh.reportsprod.evinternal.net"

  // external endpoints lambda env variable
  legacy_endpoint            = "https://intranetrest.cmh.reportsprod.evinternal.net/"
  ev_json_convertor_endpoint = "https://api.cmh.platform-prod2.evinternal.net/factory-dx-human-extraction/pmf-conversion/converter"

  // external URL to call form state machine
  ENDPOINT_URL_LEGACY      = "https://intranetrest.cmh.reportsprod.evinternal.net"
  ENDPOINT_URL_3DMODELLING = "http://measurement-service.cmh.pgprod.evinternal.net"               
  ENDPOINT_URL_MA          = "https://api.cmh.platform-prod2.evinternal.net/factory-automeasure"
  ENDPOINT_URL_HIPSTER     = "https://api.cmh.platform-prod2.evinternal.net/inform-measures"

  // IAM Role of Monolith Legacy Reports
  legacy_report_account = "435205879315"

  // factory account id
  evtech_factory_account = "210267306867"

  // EKS Cluster ID.  Used to allow services from this cluster to call lambda functions.
  eks_cluster_id = "BA458019263A15203D2AC7E9DDE7D3A8"
}
