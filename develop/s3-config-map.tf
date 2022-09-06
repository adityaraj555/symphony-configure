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
        "arn:aws:iam::671236419730:role/measurement-service-dev-callback-lambda-role",
        "arn:aws:iam::356071200662:role/sys-dev-1x22-eks-k8s-upgrade-service-role"
      ]
      actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    }
  }
}
