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
