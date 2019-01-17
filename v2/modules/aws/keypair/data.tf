data "external" "update_ssh_pem" {
  depends_on = ["local_file.pem"]

  program = ["/bin/bash", "-c", "${path.module}/.files/change_pem_permissions", "${local_file.pem.filename}"]
}
