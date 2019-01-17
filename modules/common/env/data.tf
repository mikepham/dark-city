data "external" "current_username" {
  program = ["/bin/bash", "-c", "${path.module}/.files/get_current_username.sh"]
}
