/**
 * S3 config map
 */

output "s3_config_map" {
  description = "This sets the configuration for s3 deployed in this repo"
  value = {
    "property-data-orchestrator" = {
      identifiers = [
        "arn:aws:iam::105810807432:role/us-east-2-roofmodel-blue-hermes-instance",
        "arn:aws:iam::105810807432:root",
        "arn:aws:iam::105810807432:role/us-east-2-roofmodel-green-hermes-instance",
        "arn:aws:iam::105810807432:role/EC2-Admin",
        "arn:aws:iam::105810807432:role/measurement-service-lambda-LambdaExecutionRole-6V7XQJ542YDE"   
      ]
      actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    }
  }
}
