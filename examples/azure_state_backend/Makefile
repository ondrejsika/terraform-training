terraform-state-init:
ifndef ACCESS_KEY
	$(error ACCESS_KEY is undefined)
endif
	terraform init \
		-backend-config="access_key=${ACCESS_KEY}"
