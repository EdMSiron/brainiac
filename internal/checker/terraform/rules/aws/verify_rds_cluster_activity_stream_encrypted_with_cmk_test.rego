package lib.terraform.CB_TFAWS_276

test_verify_rds_cluster_activity_stream_encrypted_with_cmk_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_rds_cluster_activity_stream",
			"default"
		],
		"Attributes": {
			"kms_key_id": "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
		},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1
		}
	}]
	count(result) == 1
}

test_verify_rds_cluster_activity_stream_encrypted_with_cmk_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_rds_cluster_activity_stream",
			"default"
		],
		"Attributes": {
			"kms_key_id": ""
		},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1
		}
	}]
	count(result) == 1
}
