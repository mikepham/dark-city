.terraform/modules:
	terraform get
	for i in $$(ls .terraform/modules/*/getvariables.rb); do \
		i=$$(dirname $$i); \
		ruby $$i/getvariables.rb > $$i/variables.tf.json; \
	done \
