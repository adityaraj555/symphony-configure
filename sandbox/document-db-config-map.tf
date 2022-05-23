/**
 * DocumentDB config map
 */

output "document_db_config_map" {
  description = "This sets the configuration for lambdas deployed in this repo"
  value = {
    name                         = "prop-data-orchestrator-datastore"
    vpc_id                       = local.lambda_vpc_id,
    db_port                      = 27017,
    master_username              = "symphonyMasterUser",
    master_password              = "Eagleview123",
    retention_period             = 35,
    preferred_backup_window      = "04:00-08:00",
    preferred_maintenance_window = "Mon:21:00-Mon:22:00",
    skip_final_snapshot          = true,
    deletion_protection          = false,
    apply_immediately            = true,
    engine                       = "docdb",
    engine_version               = "4.0.0"
    subnet_ids                   = ["subnet-04839b12c5dfb4d46", "subnet-09d7c3533984812c2", "subnet-00f8b7dc9b4c2a2e5"],
    cluster_size                 = 1,
    instance_class               = "db.t4g.medium",
    cluster_family               = "docdb4.0",
    allowed_cidr_blocks          = ["10.201.0.0/16"]
  }
}
