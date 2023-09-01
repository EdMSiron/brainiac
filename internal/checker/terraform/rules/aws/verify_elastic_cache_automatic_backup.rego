# METADATA
# title: "Verify that Amazon ElastiCache Redis clusters have automatic backup turned on"
# description: "By enabling automatic backups for Amazon ElastiCache Redis clusters is important to ensure data protection, facilitate disaster recovery, and minimize downtime in case of accidental data loss or system failures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster.html#snapshot_retention_limit
# custom:
#   id: CB_TFAWS_113
#   severity: LOW
package lib.terraform.CB_TFAWS_113

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_elasticache_cluster"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
	resource := input[_]
    isvalid(resource)
    is_number(to_number(resource.Attributes.snapshot_retention_limit))
    to_number(resource.Attributes.snapshot_retention_limit) > 0
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_elasticache_cluster' for 'snapshot_retention_limit' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_elasticache_cluster' for 'snapshot_retention_limit' should be set.",
                "snippet": block }
} 