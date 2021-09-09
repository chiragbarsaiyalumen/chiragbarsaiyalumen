#! /bin/bash
sudo yum update all
sudo yum install git -y
sudo yum install epel-release -y
sudo yum install ansible -y
sudo mkdir ansibletest
cd ansibletest
sudo git clone https://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:x-oauth-basic@github.com/saran-palanisamy/elanco-demolab.git
cd elanco-demolab
cd elanco-ansible
cd nginx-demo
sudo ansible-playbook --connection=local nginx.yml