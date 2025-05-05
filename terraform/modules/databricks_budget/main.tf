terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~>1.5"
      configuration_aliases = [databricks.account]
    }
  }
}

resource "databricks_budget" "this" {
  provider = databricks.account

  for_each = var.budgets

  display_name = each.key

  alert_configurations {
    time_period        = each.value.alert_config.time_period
    trigger_type       = each.value.alert_config.trigger_type
    quantity_type      = each.value.alert_config.quantity_type
    quantity_threshold = each.value.alert_config.quantity_threshold

    dynamic "action_configurations" {
      for_each = each.value.alert_config.action_configurations
      content {
        action_type = action_configurations.value.action_type
        target      = action_configurations.value.target
      }
    }
  }

  filter {
    workspace_id {
      operator = "IN"
      values   = each.value.filter.workspace_ids
    }
  }
}
