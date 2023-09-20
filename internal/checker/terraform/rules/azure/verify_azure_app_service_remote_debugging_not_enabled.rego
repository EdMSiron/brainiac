# METADATA
# title: "Verify that remote debugging is not enabled for app services"
# description: "This policy is designed to enhance the security and management of Azure App Services by verifying that remote debugging is disabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_035
#   severity: LOW
package lib.terraform.CB_TFAZR_035

supportedResources := ["azurerm_app_service", "azurerm_linux_web_app", "azurerm_windows_web_app"]

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == supportedResources[_]
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
	block := input[_]
	isvalid(block)
	innerBlock := block.Blocks[_]
	innerBlock.Type == "site_config"
	innerBlock.Attributes.remote_debugging_enabled == false
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "Remote debugging is not enabled for the App Service.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "Remote debugging is enabled for the App Service.",
		"snippet": block,
	}
}