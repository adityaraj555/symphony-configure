/**
 * DocumentDB config map
 */

output "s3_config_map" {
  description = "This sets the configuration for s3 deployed in this repo"
  value = {
    "property-data-orchestrator" = {
      identifiers = [
        "arn:aws:iam::366384665027:role/us-east-2-roofmodel-blue-hermes-instance",
        "arn:aws:iam::366384665027:root",
        "arn:aws:iam::366384665027:role/us-east-2-roofmodel-green-hermes-instance",
        "arn:aws:iam::366384665027:role/EC2-Admin"         
      ]
      actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    }
  }
}
