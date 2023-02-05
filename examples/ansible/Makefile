ansible:
	echo "${HOST} ansible_user=root ansible_ssh_common_args='-o StrictHostKeyChecking=no'" > hosts
	ansible-playbook -i hosts site.yml
	rm -rf hosts
