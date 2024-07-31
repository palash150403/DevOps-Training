# Day16-task

## Project 1: Deploying Ansible

### Problem Statement
You are tasked with deploying Ansible in a multi-node environment consisting of multiple Linux servers. The goal is to set up Ansible on a control node and configure it to manage several managed nodes. This setup will be used for automating system administration tasks across the network.

### Deliverables
#### Control Node Setup
-   Install Ansible on the control node.
-   Configure SSH key-based authentication between the control node and managed nodes.
#### Managed Nodes Configuration
-   Ensure all managed nodes are properly configured to be controlled by Ansible.
-   Verify connectivity and proper setup between the control node and managed nodes.
#### Documentation


```
server ansible_host=3.101.118.225 ansible_user=ubuntu ansible_ssh_private_key_file=ansible-new.pem

```
![alt text](<Screenshot from 2024-07-30 16-36-27.png>)

inventory.ini file

## Project 2: Ad-Hoc Ansible Commands

### Problem Statement
Your organization needs to perform frequent, one-off administrative tasks across a fleet of servers. These tasks include checking disk usage, restarting services, and updating packages. You are required to use Ansible ad-hoc commands to accomplish these tasks efficiently.
### Deliverables
#### Task Execution
-   Execute commands to check disk usage across all managed nodes.
-   Restart a specific service on all managed nodes.
-   Update all packages on a subset of managed nodes.

#### Command Scripts
-   Create a script or documentation for each task, detailing the ad-hoc command used and its output.
#### Documentation
-   Execute commands to check disk usage across all managed nodes.

![alt text](<Screenshot from 2024-07-30 16-38-55.png>)

-   Restart a specific service on all managed nodes.

![alt text](<Screenshot from 2024-07-30 16-44-04.png>)

![alt text](<Screenshot from 2024-07-30 16-48-54.png>)

-   Update all packages on a subset of managed nodes.
![alt text](<Screenshot from 2024-07-30 17-05-35.png>)




## Project 3: Working with Ansible Inventories

### Problem Statement
You need to manage a dynamic and diverse set of servers, which requires an organized and flexible inventory system. The project involves creating static and dynamic inventories in Ansible to categorize servers based on different attributes such as environment (development, staging, production) and roles (web servers, database servers).
### Deliverables
#### Static Inventory
-   Create a static inventory file with different groups for various environments and roles.
-   Verify that the inventory is correctly structured and accessible by Ansible.

#### Dynamic Inventory
-   Implement a dynamic inventory script or use a dynamic inventory plugin.
-   Configure the dynamic inventory to categorize servers automatically based on predefined criteria.

#### Documentation
-   Instructions for setting up and using static and dynamic inventories.
-   Examples of playbooks utilizing both types of inventories.

## Project 4: Ansible Playbooks: The Basics

### Problem Statement
Your team needs to automate repetitive tasks such as installing packages, configuring services, and managing files on multiple servers. The project involves writing basic Ansible playbooks to automate these tasks, ensuring consistency and efficiency in the operations.

### Deliverables
#### Playbook Creation
-   Write a playbook to install a specific package on all managed nodes.
-   Create a playbook to configure a service with specific parameters.
-   Develop a playbook to manage files, such as creating, deleting, and modifying files on managed nodes.

#### Testing and Verification
-   Test the playbooks to ensure they run successfully and perform the intended tasks.
-   Validate the changes made by the playbooks on the managed nodes.

#### Documentation
-   Playbook to install a specific package on all managed nodes.
```
---
- name: playbook for tasks
  hosts: all

  tasks: 
  - name: Installing packages on managed nodes
    apt:
      name: nginx
      state: present
```
![alt text](<Screenshot from 2024-07-30 17-28-29.png>)

-   Playbook to configure a service with specific parameters.
```
---
- name: playbook for tasks
  hosts: all

  tasks:
  - name: start nginx
    service:
      name: nginx
      state: started
```
![alt text](<Screenshot from 2024-07-30 17-31-07.png>)
-   Playbook to manage files, such as creating, deleting, and modifying files on managed nodes.

```

---
- name: playbook to creating, deleting, and modifying files on managed nodes
  hosts: all
  tasks:
    - name: Create file
      file:
        path: /home/ubuntu/day16-tasks/file1.txt
        state: touch
    - name: Modifying file
      lineinfile:
        path: /home/ubuntu/day16-tasks/file1.txt
        line: This is the new line added
        state: present
        create: true
    - name: Delete file
      file:
        path: /home/ubuntu/day16-tasks/file1.txt
        state: absent
```
![alt text](<Screenshot from 2024-07-30 18-11-18.png>)

## Project 5: Ansible Playbooks - Error Handling
### Problem Statement
In a complex IT environment, tasks automated by Ansible playbooks may encounter errors due to various reasons such as incorrect configurations, unavailable resources, or network issues. The project focuses on implementing error handling in Ansible playbooks to ensure resilience and proper reporting of issues.
### Deliverables
#### Playbook with Error Handling
-   Write a playbook that includes tasks likely to fail, such as starting a non-existent service or accessing a non-existent file.
-   Implement error handling strategies using modules like block, rescue, and always.
#### Logging and Notifications
-   Configure the playbook to log errors and notify administrators of any issues encountered during execution.
-   Use Ansible modules to send notifications via email or other communication channels.

#### Documentation
```
---
- hosts: all
  tasks:
  - name: Handleing the error
    block:
      - name: Print a message
        ansible.builtin.debug:
          msg: 'executed normally'

      - name: Forceing failure
        ansible.builtin.command: /bin/false

      - name: Never print this
        ansible.builtin.debug:
          msg: 'I never execute, due to the above task failing, :-('
    rescue:
      - name: Print when errors
        ansible.builtin.debug:
          msg: 'I caught an error, can do stuff here to fix it, :-)'
    always:
       - name: Always do this
         ansible.builtin.debug:
           msg: "This always executes, :-)"
 
```
![alt text](<Screenshot from 2024-07-30 18-17-06.png>)
