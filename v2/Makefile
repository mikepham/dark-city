.terraform/modules:
	terraform get
	for i in $$(ls .terraform/modules/*/Makefile); do i=$$(dirname $$i); make -C $$i; done
