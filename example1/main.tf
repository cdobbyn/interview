resource "tfe_workspace" "this" {
  for_each = local.workspaces

  name         = "${replace(var.workspace_path, "/", "-")}-${each.key}"
  organization = var.org

  description                   = lookup(each.value, "description", null)
  agent_pool_id                 = lookup(each.value, "agent_pool_id", null)
  allow_destroy_plan            = lookup(each.value, "allow_destroy_plan", true)
  auto_apply                    = lookup(each.value, "auto_apply", false)
  execution_mode                = lookup(each.value, "execution_mode", "remote")
  assessments_enabled           = lookup(each.value, "assessments_enabled", false)
  file_triggers_enabled         = lookup(each.value, "file_triggers_enabled", true)
  global_remote_state           = lookup(each.value, "global_remote_state", false)
  remote_state_consumer_ids     = lookup(each.value, "remote_state_consumer_ids", [])
  project_id                    = lookup(each.value, "project_id", null)
  queue_all_runs                = lookup(each.value, "queue_all_runs", true)
  speculative_enabled           = lookup(each.value, "speculative_enabled", true)
  structured_run_output_enabled = lookup(each.value, "structured_run_output_enabled", true)
  ssh_key_id                    = lookup(each.value, "ssh_key_id", null)
  tag_names                     = lookup(each.value, "tag_names", [])
  terraform_version             = lookup(each.value, "terraform_version", null)
  trigger_prefixes              = lookup(each.value, "trigger_prefixes", null)
  trigger_patterns              = lookup(each.value, "trigger_patterns", null)
  working_directory             = lookup(each.value, "working_directory", null)

  dynamic "vcs_repo" {
    for_each = lookup(each.value, "vcs_repo_enabled", true) ? [1] : []
    content {
      identifier         = lookup(each.value, "vcs_repo_identifier", "pscloudops/terraform-infrastructure")
      branch             = lookup(each.value, "vcs_repo_branch", "main")
      ingress_submodules = lookup(each.value, "vcs_repo_ingress_submodules", false)
      oauth_token_id     = lookup(each.value, "vcs_repo_oauth_token_id", "ot-11vkZk6iXsPiv86H")
    }
  }
}
