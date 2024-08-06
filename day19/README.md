# Day 19 Task

### Problem Statement
You are tasked with deploying a three-tier web application (frontend, backend, and database) using Ansible roles. The frontend is an Nginx web server, the backend is a Node.js application, and the database is a MySQL server. Your solution should use Ansible Galaxy roles where applicable and define appropriate role dependencies. The deployment should be automated to ensure that all components are configured correctly and can communicate with each other.

## Deliverables

**1. Create Directory Structure**

Create a new Ansible project with a suitable directory structure to organize roles, playbooks, and inventory files.


**2. Role Definitions and Dependencies**
meta/main.yml files for each role defining dependencies.
Customized roles with necessary configurations.

![alt text](<task/Screenshot from 2024-08-06 22-59-33.png>)

**3. Inventory File**
Inventory file defining groups and hosts for frontend, backend, and database tiers.

![alt text](<img/Screenshot from 2024-08-06 00-07-59.png>)

```ini
[frontend]
app-node-01 ansible_host=**.***.***.*** ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/day18/task/ansible-new.pem

[backend]
backend-01 ansible_host=**.***.***.*** ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/day18/task/ansible-new.pem

[database]
db-01 ansible_host=**.***.***.*** ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/day18/task/ansible-new.pem

```

**4. Create Playbook (main.yml)**
Playbook that orchestrates the roles  deployment of the three-tier application.

```yml
---
- name: Full Stack Application
  hosts: all
  become: yes
  tasks:
    - name: update_cache
      apt:
        update_cache: yes

- hosts: database
  become: true
  roles: 
    - database

- hosts: backend
  become: true
  roles: 
    - backend

- hosts: frontend
  become: true
  roles: 
    - frontend
```

**5. Playbook main.yml**
A playbook that ensures the successful deployment and functionality of each tier.

![alt text](<task/Screenshot from 2024-08-06 18-11-24.png>) 
![alt text](<task/Screenshot from 2024-08-06 18-11-32.png>) 

**Frontend Output**
![alt text](<task/Screenshot from 2024-08-06 18-13-04.png>)

