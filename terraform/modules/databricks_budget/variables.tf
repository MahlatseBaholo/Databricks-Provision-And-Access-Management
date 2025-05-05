variable "budgets" {
  type = map(object({
    alert_config = object({
      time_period        = string
      trigger_type       = string
      quantity_type      = string
      quantity_threshold = string
      action_configurations = list(object({
        action_type = string
        target      = string
      }))
    })
    filter = object({
      workspace_ids = list(string)
    })
  }))
}
