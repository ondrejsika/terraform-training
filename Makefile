fmt:
	terraform fmt -recursive

fmt-check:
	terraform fmt -recursive -check

lint-check:
	tflint --recursive \
		--disable-rule terraform_typed_variables \
		--disable-rule terraform_required_providers \
		--disable-rule terraform_required_version

setup-git-hooks:
	rm -rf .git/hooks
	(cd .git && ln -s ../.git-hooks hooks)

examples-terraform-providers-lock:
	find ./examples/* \
		-type dir \
		-maxdepth 0 \
		-exec terraform \
			-chdir={} \
			providers lock \
				-platform=darwin_arm64 \
				-platform=darwin_amd64 \
				-platform=linux_arm64 \
				-platform=linux_amd64 \;

cleanup-digitalocean-account-after-training:
ifndef DIGITALOCEAN_TOKEN
	$(error DIGITALOCEAN_TOKEN is undefined)
endif
	slu digitalocean all delete
