#!/bin/sh

echo "$1 ansible_user=root ansible_ssh_common_args='-o StrictHostKeyChecking=no'" > hosts
pipenv install
pipenv run ansible-playbook -i hosts site.yml
rm -rf hosts
