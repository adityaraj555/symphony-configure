/**
 * S3 config map
 */

output "s3_config_map" {
  description = "This sets the configuration for s3 deployed in this repo"
  value = {
    "property-data-orchestrator" = {
      identifiers = [
        "arn:aws:iam::${local.evtech_factory_account}:role/us-east-2-roofmodel-blue-hermes-instance",
        "arn:aws:iam::${local.evtech_factory_account}:root",
        "arn:aws:iam::${local.evtech_factory_account}:role/us-east-2-roofmodel-green-hermes-instance",
        "arn:aws:iam::${local.evtech_factory_account}:role/EC2-Admin",
        "arn:aws:iam::${local.evtech_factory_account}:role/measurement-service-${local.environment}-callback-lambda-role",
        "arn:aws:iam::${local.legacy_report_account}:root",
        "arn:aws:iam::${local.legacy_report_account}:role/evmuApplication"
      ]
      actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    }
  }
}
