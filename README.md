# Dockerfile with Ansible 2.6

Dockerfile to build container aith Ansible 2.6.1 based on python 2.7 (alpine build 3.13)

Original work by https://github.com/willhallonline/docker-ansible

## Running

`docker run --rm -it -v $(pwd)/test.yml:/ansible/playbook.yml -v ~/.ssh/id_rsa:/root/.ssh/id_rsa --workdir=/ansible pavelsg/ansible:2.6.1-alpine ansible-playbook -i '127.1.1.1,' -e 'ansible_port=3522' -e 'ansible_user=ubuntu' -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" playbook.yml`
