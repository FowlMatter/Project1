## Automated ELK Stack Deployment

__The files in this repository were used to configure the network depicted below.__

![Network Diagram](https://github.com/FowlMatter/Project1/blob/master/Diagrams/RedElkVNetworkDiagram.png)

These files are debugged and generate a live ELK deployment on Azure. They Create the deployment pictured above. Alternatively, select portions of the Ansible Playbook file may be used to install only certain pieces of it, such as Filebeat.

#### The playbook used to build this Virtual Network is:
[ELKStack full Deployment Playbook](https://github.com/FowlMatter/Project1/blob/master/Ansible/ELKStackFileMetricsBeat-playbook.yml)

#### This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
- Beats in Use
- Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.
Load balancing ensures that the application will be highly **resilient** in addition to restricting **access** to the network.

By providing the public IP for the webserver network, and receiving all website traffic, the load balancer can evenly distribute it to multiple servers. It also minimizes threat of DoS on one or more overloaded servers by spreading the load to multiple servers. By maintaining the distribution point of HTTP traffic to all backpool webservers, the load balancer permits shutting down and replacing a malfunctioning server or adding additional resources while distributing the load across the rest of the webserver network. The load balancer is another layer in the security onion blocking intrusion into the webserver VNetwork and securing network resources from outside infiltration.

The network's administration gateway is Jumpbox. Jumpbox protects the network from security breaches by blocking all incoming ssh traffic into the Virtual Network. These Docker containers can only be logged into via ssh with public/private ssh-key key-pair from the jumpbox ip, further preventing unwanted access to the Virtual network. Another layer of protection is provided as Jumpbox is configured so it can communicate on the backend with the Webserver VNetwork via ssh-key on Port 22 AND on the front end with ssh, port 22, but only from the sysadmin computer's IP. By controlling access through IP address restriction and requiring a different ssh-key from sysadmin IP to Jumpbox than the ssh-key from Jumpbox to V-Net the V-Net is hardened against IP spoofing or similar intrusion attempts. The Elk server is configured similar to the webserver V-Net, however the Jumpbox/Elk backend communication utilize ssh on port 5601, the ELKStack default port. This "gateway" configuration permits sysadmin exclusive access to the jumpbox, and through it, the entire V-Net.

#### Integrating an ELK server with Beats modules allows users to easily monitor the vulnerable VMs for changes to the Metrics and System Logs.
FileBeat monitors system logs. Referred to as  a lightweight shipper, FileBeat is one of the Elastic Beat modules available for the ELK stack. Basically a data miner for the ELK stack it forwards new log data via Logstash or Elastisearch to the ELKStack for analysis and monitoring on Kabana. By monitoring for log events, it can harvest new content for transfer. FileBeat can be configured to monitor and track log events from remote systems across the network

MetricBeat performs similarly to FileBeat, however it is collecting and forwarding the system metrics and statistics, the performance data, of various running services on the network servers.  Services such as Apache, MySQL and Nginx to mention a few of the many supported can have specific metrics. Metrics such as CPU usage or memory availability, network activity or dozens of supported system specific metrics can be collected and forwarded to Logstash, or directly inserted into Elastisearch.

#### The configuration details of each machine may be found below.

| Name     | Function | IP Address |  Operating System   |
|----------|----------|------------|---------------------|
| Jump Box | Gateway  | 10.1.0.4   | Debian Ubuntu 18.04 |
| ELKStack |  SIEM    | 10.1.0.5   | Debian Ubuntu 18.04 |
| DVWA-Web1|Webserver | 10.2.0.4   | Debian Ubuntu 18.04 |
| DVWA-Web2|Webserver | 10.2.0.5   | Debian Ubuntu 18.04 |
| DVWA-Web3|Webserver | 10.2.0.6   | Debian Ubuntu 18.04 |
| DVWA-Web4|Webserver | 10.2.0.7   | Debian Ubuntu 18.04 |

### Access Policies

The machines on the internal network are not exposed to the public Internet. The load balancer presents the public ip address for the 4 webservers, separating them from public HTTP traffic. The ELKStack machine can accept HTTP connections on port 9200 from outside the V-Network, access is restricted to the following IP addresses:
 - 66.190.244.194 - sysadmin

The 5 VMs within the network can only be accessed by SSH from JumpBox 10.1.0.4. The ELKStack can recieve webserver logs and metrics data from Filebeat and Metricbeat via ssh from the 4 webservers, however the webservers and ELKStack all share the same half of the public/private ssh keypair eliminating the possibility of intranet login or access beyond what is shared by the Beats programs.  

#### A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses  |
|----------|---------------------|-----------------------|
| Jump Box | Yes - Public IP     |    66.190.244.194     |
|ELKStack  | Yes - Public ip     |66.190.244.194 10.1.0.4|
|DVWA-Web* | No - Load Balancer  | 10.1.0.4 20.42.37.12  |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine, no configuration was performed manually. There are many advantages to this strategy, starting with reliability. By automating the configuration task the user can reproduce the same ELKStack in a few moments should the need arise. This allows rapid, replication of a replacement ELK for any reason or an additional ELK for scalability as the network demands grow. Automation also greatly reduces the risk of human error being introduced into the deployment.

The playbook implements the following tasks:

1-Reads configuration files for specific settings reflective of this deployment.

2-Downloads IO system and services, docker image and configured with the necessary system resources, CPU, enough RAM etc. software, port configuration, and reconfigures the maximum memory settings to increase memory access required by an ELK machine thus becoming a fully provision and configured docker ELK container.

3-Enables docker service.

#### The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
![Configuration Diagram](https://github.com/FowlMatter/Project1/blob/master/Ansible/Images/ELK_PS_StatusScreenshot.png)

#### Target Machines & Beats
This ELK server is configured to monitor the following machines:

The webserver group:

DVWA-Web1 10.2.0.4 - FileBeat and MetricBeat Installed

DVWA-Web2 10.2.0.5 - FileBeat and MetricBeat Installed

DVWA-Web3 10.2.0.6 - FileBeat and MetricBeat Installed

DVWA-Web4 10.2.0.7 - FileBeat and MetricBeat Installed

FileBeats and MetricBeats are installed, running and shipping logs and metrics to ELKStack.

FileBeats collects updates of new content from the system logs on all 4 webservers. By only sending new content it greatly reduces network load sending complete logfile uploads would create. We would expect for example, updates of new content of audit logs generated by log events. These log events tell filebeat the log has new content added to it. These logs can be used to track user logon info, destination and source addresses and timestamp info to name a few. The following logs can also provide additional resources for system monitoring; deprecation logs, gc logs, server logs, and slow logs.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:

Copy the YAML file ELKStackFileMetricBeat-playbook.yml Playbook file to Ansible container Quizzical_kowalevski /etc/ansible.

Update the Hosts file to include both ELK and Webservers group IPs reflective of the deployment network IPs 10.2.0.4, 10.2.0.5, 10.2.0.6 and 10.2.0.7 then, update the ELK group to 10.1.0.5
- Run the playbook, and navigate to Kabana website and verify the ELKStack is getting data to check that the installation worked as expected.

For this deployment the ansible playbook created is ELKStackFileMetricBeat-playbook.yml 

To run the playbook for this VNetwork, it resides on the Ansible Jumpbox Container Quizzical Kowalevski, in the /etc/ansible directory. Prior to running the playbook,the hosts file (/etc/ansible/hosts) must be modified to include the servers affected. i.e. Webservers is a group that can be defined with the IPs of the DVWA-Web1-4. ELK is another group, one defined by the ELKStack IP This is useful for deploying services to entire groups rather than individual machines.

Specify which machine to install the ELK server on, vs. which to install Filebeat and Metricbeat on in the Ansible playbook. Each of the docker containers being deployed has been pre-defined in the /etc/ansible/hosts file. When a service like DVWA, MetricBeats, FileBeats, or ELK is installed, they are each their own stand alone deployments daisy chained together in a script, known as a playbook. When the first service creating the 4 DVWA containers completes, it then starts the ELK container deployment. The Filebeat and Metricbeat follow. In all 4 deployments as they are called from the playbook the first line of their script is the name of the deployment like "Config ELK VM with Docker" for example. The next line in this example is hosts: elk. This specifies the ELKStack will be deployed to elk as defined in the /etc/ansible/hosts file. In this case, the elkserver is at 10.1.0.5. Conversly, the FileBeats and MetricBeats services are installed, the hosts listed in their playbook are the webserver group at 10.2.0.[4-7]

[Which URL do you navigate to in order to check that the ELK server is running?](http://40.83.165.244:5601/app/kibana#/home)

#### Cookbook to Deploy ELKStack Container to Existing Virtual Network with Configured Ansible Control Node 

sudo ssh -i ~/.ssh/RedKey_id_rsa azdmin@137.135.46.107

sudo systemctl status docker

sudo systemctl start docker (if not running)

sudo docker start quizzical_kowalevski

sudo docker attach quizzical_kowalevski

cd /etc/ansible

nano ansible-playbook.yml make deployment specific edits

nano hosts make deployment specific edits to intended IPs of hosts.

cd ansible-cfg/roles

nano filebeat-playbook.yml set hosts:webservers

nano metricbeat-playbook.yml set hosts:webservers

cd ../files

nano filebeat-config.yml on line 1107 set hosts "10.1.0.5:9200"

set line 1807 hosts: "10.1.0.5:5601"

cd ../metrics

nano metricbeat-config.yml set line 62 hosts: "10.1.0.5:5601"

set line 94 hosts: ["10.1.0.5:9200"]

cd

ansible-playbook /etc/ansible/ELKStackFileMetricBeat-playbook.yml

open web browser go to kabana site and verify ELKStack receiving log and metrics data.
[URLyou navigate to in order to check that the ELK server is running](http://40.83.165.244:5601/app/kibana#/home)