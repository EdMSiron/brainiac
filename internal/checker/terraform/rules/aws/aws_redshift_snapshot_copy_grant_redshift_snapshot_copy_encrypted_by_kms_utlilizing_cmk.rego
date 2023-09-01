# METADATA
# title: "A customer managed Key (CMK) should be used to encrypt the RedShift snapshot copy"
# description: "This quick test verifies that the RedShift snapshot copy encrypts its contents with AWS key management - KMS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_snapshot_copy_grant
# custom:
#   id: CB_TFAWS_265
#   severity: HIGH
package lib.terraform.CB_TFAWS_265

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_redshift_snapshot_copy_grant"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "kms_key_id")
    resource.Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Customer Managed Key (CMK) is used to encrypt the RedShift snapshot copy.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Customer Managed Key (CMK) must be used to encrypt the RedShift snapshot copy.",
                "snippet": block }
} 