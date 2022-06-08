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
    retention_period             = 35,
    preferred_backup_window      = "04:00-08:00",
    preferred_maintenance_window = "Mon:21:00-Mon:22:00",
    skip_final_snapshot          = true,
    deletion_protection          = false,
    apply_immediately            = true,
    engine                       = "docdb",
    engine_version               = "4.0.0"
    subnet_ids                   = ["subnet-05dc38b74a3938e99", "subnet-01f4c915a615300a7", "subnet-0562d714b1bf9b87a"],
    cluster_size                 = 1,
    instance_class               = "db.t4g.medium",
    cluster_family               = "docdb4.0",
    allowed_cidr_blocks          = ["10.241.0.0/16"]
  }
}
