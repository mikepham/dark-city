data "external" "env" {
  program = ["/bin/bash", "-c", "${path.module}/.files/env.sh"]
}
