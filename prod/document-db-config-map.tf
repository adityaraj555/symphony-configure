/**
 * DocumentDB config map
 */

output "document_db_config_map" {
  description = "This sets the configuration for lambdas deployed in this repo"
  value = {
    name                         = "prop-data-orchestrator-datastore1"
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
    subnet_ids                   = ["subnet-0f71d0fae70c53821", "subnet-0f83032ea0c0419ed", "subnet-0c10923aa5dc00685"],
    cluster_size                 = 1,
    instance_class               = "db.r6g.xlarge",
    cluster_family               = "docdb4.0",
    allowed_cidr_blocks          = ["10.240.0.0/16"]
  }
}
