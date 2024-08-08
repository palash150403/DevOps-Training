# Day 21 Task

## 1. Inventory Plugins

 - **Activity**: Set up a dynamic inventory plugin to manage an expanding fleet of web servers dynamically. Connect the plugin with Ansible to automatically discover and configure servers across different environments.
 - **Deliverable**: A dynamic inventory configuration file or script that showcases the capability to automatically refresh the inventory by reflecting real-time server data.

ansible.cfg
```conf
[defaults]
private_key_file=/home/einfochips/day21/ansible-new.pem
remote_user = ubuntu
host_key_checking = False
forks

[inventory]
enable_plugins = amazon.aws.aws_ec2
```

aws_ec2.yml
```yml
plugin: amazon.aws.aws_ec2
regions:
  - us-west-1

filters:
  instance-state-name:
    - running

hostnames:
  - dns-name

compose:
  ansible_host: public_dns_name
```

Commands: 

``` bash
# to get detailed information about running instances
ansible-inventory -i aws_ec2.yml --list


ansible-inventory -i aws_ec2.yml --graph
```

![alt text](<img/Screenshot from 2024-08-08 17-43-17.png>)

## 2. Performance Tuning

 - **Activity**: Tune Ansible performance by adjusting settings such as parallel execution (forks), optimizing playbook tasks, and reducing playbook run time.
 - **Deliverable**: Optimized ansible.cfg configuration file, performance benchmarks, and documentation detailing changes made for performance improvement.

```conf
[defaults]
forks = 50

[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s
pipelining = True
```

## 3. Debugging and Troubleshooting Playbooks

 - **Activity**: Develop and apply debugging techniques to detect and fix problems in playbooks, such as enabling detailed output and incorporating advanced error management.
 - **Deliverable**: Playbooks with improved error handling and logging, and created a troubleshooting guide covering common issues and their solutions.

Commands: 

```bash
# -v -> task result
ansible-playbook -i inventory.ini docker-playbook.yml -v

# -vv -> task input and output
ansible-playbook -i inventory.ini docker-playbook.yml -vv

# -vvv -> task execution
ansible-playbook -i inventory.ini docker-playbook.yml -vvv

# -vvvv -> ansible internal details
ansible-playbook -i inventory.ini docker-playbook.yml -vvvv
```


## 4. Exploring Advanced Modules

 - **Activity**: Use advanced Ansible modules such as docker_container to manage containerized applications and aws_ec2 for AWS infrastructure management, demonstrating their integration and usage.
 - **Deliverable**: Playbooks showcasing the deployment and management of Docker containers and AWS EC2 instances, along with documentation on the benefits and configurations of these advanced modules.

**Docker Container Module Example -**

```yml
- name: Docker Container Creation
  hosts: localhost
  tasks:
  - name: Create and start Docker container
    community.docker.docker_container:
      name: my_nginx
      image: nginx:latest
      state: started
      ports:
      - "8084:80"
      volumes:
      - /my/local/path:/usr/share/nginx/html
```

**AWS ec2 Module Example -**

```yml
- name: Launch an EC2 instance
  hosts: localhost
  tasks:

  - name: Create security group
    amazon.aws.ec2_security_group:
      name: "new-security-group"
      description: "Sec group for app"
      rules:                               
        - proto: tcp
          ports:
            - 22
          cidr_ip: 0.0.0.0/0
          rule_desc: allow all on ssh port
```

![alt text](<img/image.png>) 
![alt text](<img/Screenshot from 2024-08-08 21-59-03.png>) 



