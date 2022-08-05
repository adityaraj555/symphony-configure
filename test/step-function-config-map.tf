/**
 * Step Function config map
 */

output "step_function_config_map" {
  description = "This sets the configuration for step-functions deployed in this repo"
  value = {
    "${local.symphony_workflow_name}" = {
      source_path = "../../stepfunctions/symphony-workfow/state-machine.json",
      sfn_def_env_vars = {
      region        = "${local.region}",
      resource_name_prefix = "${local.resource_name_prefix}",
      ENDPOINT_URL_LEGACY = "${local.ENDPOINT_URL_LEGACY}",
      ENDPOINT_URL_3DMODELLING = "${local.ENDPOINT_URL_3DMODELLING}",
      ENDPOINT_URL_MA = "${local.ENDPOINT_URL_MA}",
      ENDPOINT_URL_HIPSTER = "${local.ENDPOINT_URL_HIPSTER}",
      ENDPOINT_URL_UPLOAD_PDW = "${local.upload_pdw}",
      ENDPOINT_URL_PMF_CONVERTER = "${local.ev_json_convertor_endpoint}"
      }
    },
    "${local.ais_workflow_name}" = {
      source_path = "../../stepfunctions/ais/state-machine.json",
      sfn_def_env_vars = {
      region        = "${local.region}",
      resource_name_prefix = "${local.resource_name_prefix}",
      ARN_IMAGERY_CHECK = "${local.ARN_IMAGERY_CHECK}",
      ARN_BUILDING_DETECTION = "${local.ARN_BUILDING_DETECTION}",
      ARN_IMAGE_SELECTION = "${local.ARN_IMAGE_SELECTION}",
      ARN_UPLOAD_IMAGE="${local.ARN_UPLOAD_IMAGE}"
      ENDPOINT_URL_LEGACY = "${local.ENDPOINT_URL_LEGACY}",
      }
    }
  }
}