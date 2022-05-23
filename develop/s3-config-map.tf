/**
 * DocumentDB config map
 */

output "s3_config_map" {
  description = "This sets the configuration for s3 deployed in this repo"
  value = {
    "property-data-orchestrator" = {
      identifiers = [
        "arn:aws:iam::671236419730:role/EC2-Admin",
        "arn:aws:iam::671236419730:role/us-east-2-dev-default-hermes-instance",
        "arn:aws:iam::671236419730:root",
        "arn:aws:iam::671236419730:role/measurement-service-lambda-LambdaExecutionRole-1AXK8XB6KLRTH"         
      ]
      actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    }
  }
}
