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

  // Name of the upload_image lambda function
  uploadimage_lambda_name = "uploadimage"

  // name of the sim2pdw lambda function
  sim_to_pdw_lambda_name = "sim2pdw"

  // Name of the query_pdw lambda function
  querypdw_lambda_name = "querypdw"

  // Name of the notifyerror lambda function
  sfnnotifier_lambda_name = "sfnnotifier"

  // Name of the hipster eligibility lambda
  checkhipstereligibility_lambda_name = "checkhipstereligibility"

  // Name of the symphony workflow
  symphony_workflow_name = "symphony_workflow"

  // Name of the AIS workflow
  ais_workflow_name = "ais"

  // Name of the symphony workflow
  sim_workflow_name = "sim"

  // Name of the sqs queue
  receive_legacy_order_queue_name = "receiveLegacyOrder"

  // Name of the sqs queue
  receive_sim_order_queue_name = "receiveSIMOrder"

  // Account id
  account_id = "249106962406"

  // ECR PATH.
  ecr_path = "176992832580.dkr.ecr.${local.region}.amazonaws.com/property-data-orchestrator"

  // VPC where lambdas will be installed
  lambda_vpc_id = "vpc-09d95204cb5271921"

  // slack channel to send error notifications
  slack_channel = "C03K2EQSRQQ"

  // secret manager ARN
  property_data_orchestration_secret = "arn:aws:secretsmanager:us-east-2:${local.account_id}:secret:property-data-orchestrator-secret-SfXCVm"
  property_data_orchestration_s3 = "app-${local.environment}-1x0-s3-property-data-orchestrator"

  endpoint_url_legacy = "https://intranetrest.cmh.reportsprod.evinternal.net"

  // external endpoints lambda env variable
  legacy_endpoint            = "https://intranetrest.cmh.reportsprod.evinternal.net/"
  ev_json_convertor_endpoint = "https://api.cmh.platform-prod2.evinternal.net/factory-dx-human-extraction/pmf-conversion/converter"
  upload_pdw = "https://api.cmh.platform-prod2.evinternal.net/factory-dx-human-extraction/pmf-conversion/pdw"
  auth_endpoint = "https://api.eagleview.com/auth-service"
  graph_endpoint = "https://api.cmh.platform-prod2.evinternal.net/graph"

  // external URL to call form state machine
  ENDPOINT_URL_LEGACY      = "https://intranetrest.cmh.reportsprod.evinternal.net"
  ENDPOINT_URL_3DMODELLING = "https://measurement-service.cmh.pgprod.evinternal.net"               
  ENDPOINT_URL_MA          = "https://api.cmh.platform-prod2.evinternal.net/factory-automeasure"
  ENDPOINT_URL_HIPSTER     = "https://api.cmh.platform-prod2.evinternal.net/inform-measures"
  evoss_endpoint           = "https://evossapi.cmh.reportsprod.evinternal.net"

  // external Lambdas ARN to call form ais state machine
  ARN_IMAGERY_CHECK      = "arn:aws:lambda:us-east-2:${local.account_id}:function:app-${local.environment}-1x0-lambda-imagery-check"
  ARN_BUILDING_DETECTION = "arn:aws:lambda:us-east-2:${local.account_id}:function:app-${local.environment}-1x0-lambda-building-detection"
  ARN_IMAGE_SELECTION    = "arn:aws:lambda:us-east-2:${local.account_id}:function:app-${local.environment}-1x0-lambda-image-selection"
  ARN_UPLOAD_IMAGE       = "arn:aws:lambda:us-east-2:${local.account_id}:function:app-${local.environment}-1x0-lambda-uploadimage"
  ARN_QUERY_PDW = "arn:aws:lambda:us-east-2:${local.account_id}:function:app-${local.environment}-1x0-lambda-querypdw"
  ARN_SIM2_PDW = "arn:aws:lambda:us-east-2:${local.account_id}:function:app-${local.environment}-1x0-lambda-sim2pdw"
  ARN_CALLBACK = "arn:aws:lambda:us-east-2:${local.account_id}:function:app-${local.environment}-1x0-lambda-callbacklambda"


  // IAM Role of Monolith Legacy Reports
  legacy_report_account = "435205879315"

  // factory account id
  evtech_factory_account = "210267306867"

  // EKS Cluster ID.  Used to allow services from this cluster to call lambda functions.
  eks_cluster_id = "BA458019263A15203D2AC7E9DDE7D3A8"
  eks_platform_cluster_id = "DF46F756B3AE68B323A159D75C27CD2B"

  SIM_QUEUE_URL="https://sqs.us-east-2.amazonaws.com/${local.account_id}/app-${local.environment}-1x0-sqs-sim-request-queue"
  GRAPH_PUBLISH_URL="https://dx-services.cmh.platform-prod2.evinternal.net/graph-publish/api/v2/publish"
  ENDPOINT_AUTH_TOKEN="${local.auth_endpoint}/v1/token"
  EGS_REVERSE_ENDPOINT = "https://api.cmh.platform-prod2.evinternal.net/pdw/geocoder/v2/reverse"
  // SIM endpoints
  SIM_HOST_URL="https://api.cmh.platform-prod2.evinternal.net"

  //task names
  Task3DModellingService="3DModellingService"
  TaskCreateHipsterJobAndWaitForMeasurement = "CreateHipsterJobAndWaitForMeasurement"
  TaskUpdateHipsterJobAndWaitForQC = "UpdateHipsterJobAndWaitForQC"
  UpdateHipsterJobAndWaitForMeasurement = "UpdateHipsterJobAndWaitForMeasurement"


  // Slack Notification
  SLACK_ENDPOINT = "https://slack.com/api/chat.postMessage"
  Hipster_Notification_Channel = "hipsterlivefiles"
}
