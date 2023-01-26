#--------------------------------------------------------------
# Global Config
#--------------------------------------------------------------

output "workspace" {
  value = terraform.workspace
}



output "stack_context" {
  value = local.stack_context
}
