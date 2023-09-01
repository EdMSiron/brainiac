package lib.terraform.CB_TFAWS_354

test_aws_managed_iamfullaccess_policy_is_not_used {
	result := passed with input as [{
		"Type": "data",
		"Labels": [
			"aws_iam_policy",
			"managed_policy",
		],
		"Attributes": {"arn": "arn:aws:iam::aws:policy"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 2,
		},
	}]
	count(result) == 1
}

test_aws_managed_iamfullaccess_policy_is_used {
	result := failed with input as [{
		"Type": "data",
		"Labels": [
			"aws_iam_policy",
			"managed_policy",
		],
		"Attributes": {"arn": "arn:aws:iam::aws:policy/IAMFullAccess"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 2,
		},
	}]
	count(result) == 1
}
