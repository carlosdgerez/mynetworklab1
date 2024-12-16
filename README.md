# Vagrant VirtualBox Setup for Multiple VMs

This repository provides a setup guide and configuration for running **5 Vagrant machines** on **VirtualBox**. The virtual machines are interconnected via a private network and can be customized for various use cases, such as development, testing, or learning.

---

## **Description**

This project aims to explore the possibilities of Vagrant files to deploy VMs and manage infrastructure as code with a Puppet master and 4 servers running Puppet agent. 

The initial deployment was on a Windows 11 machine, but adjustments are being made for a Kali Linux deployment as well.

---

## **Table of Contents**
1. [Description](#description)
2. [Setup](#setup)
3. [Prerequisites](#prerequisites)
4. [Setup Instructions](#setup-instructions)
5. [Vagrantfile Overview](#vagrantfile-overview)
6. [Tips for Optimization](#tips-for-optimization)
7. [Troubleshooting](#troubleshooting)
8. [Contributing](#contributing)
9. [License](#license)

---

## **Setup**

To start this repo after cloning, you will need the latest versions of Vagrant and VirtualBox installed. 

This deployment uses the `Vagrantfile` to configure the initial machines in a virtual environment. Ensure your host system supports a hypervisor.

### Recommended System for 5 Vagrant VMs:
- **Processor:** Intel i5/i7 or AMD Ryzen 5/7 with 4 or more cores.
- **RAM:** 16 GB or higher.
- **Storage:** SSD with at least 256 GB free space (SSD improves performance significantly).
- **Operating System:** 64-bit OS with virtualization enabled in the BIOS/UEFI.

---

## **Prerequisites**

Before setting up, ensure your system meets the following requirements:

### **Hardware Requirements:**
- **Processor:** Multi-core CPU with virtualization support (e.g., Intel VT-x or AMD-V). At least **4 cores** recommended.
- **RAM:** Minimum **8 GB** (16 GB or higher recommended).
- **Storage:** At least **100 GB** of free space (SSD recommended for performance).

### **Software Requirements:**
- **Operating System:** 64-bit Windows, macOS, or Linux.
- **Virtualization Software:** [VirtualBox](https://www.virtualbox.org/).
- **Vagrant:** Install from [Vagrant's official site](https://www.vagrantup.com/).
- **VirtualBox Guest Additions:** Ensure Guest Additions are installed for better VM performance.

### **Enable Virtualization:**
- Ensure virtualization is enabled in your system's BIOS/UEFI settings.

---

## **Setup Instructions**

### 1. Clone the Repository:
```bash
git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name
```

### 2. Install Dependencies:
- Install **VirtualBox** and **Vagrant** if not already installed.

### 3. Configure the Vagrant Environment:
- The included `Vagrantfile` is preconfigured for 5 virtual machines with the following specifications:
  - **Base Box:** Ubuntu Bionic 64-bit (`ubuntu/bionic64`)
  - **RAM per VM:** 1 GB
  - **CPU per VM:** 1 core
  - **Networking:** Private network with DHCP

#### To customize the setup:
- Edit the `Vagrantfile` to adjust RAM, CPU, or network settings.

### 4. Start the Virtual Machines:
```bash
vagrant up
```
This command will:
- Download the base box if it isn't already available.
- Create and start 5 VMs with the specified configuration.

### 5. Verify the Setup:
- Check the status of the VMs:
```bash
vagrant status
```
- SSH into a specific VM:
```bash
vagrant ssh vm1
```
- Test connectivity between VMs using `ping`:
```bash
ping <VM_IP_Address>
```

---

## **Vagrantfile Overview**

Below is a summary of the `Vagrantfile` configuration:

```ruby
Vagrant.configure("2") do |config|
  # Define the base box to use
  config.vm.box = BOX  # You can choose any base box
  config.vm.boot_timeout= 300
  config.ssh.insert_key = true

  # Define the load balancer VM with a static IP
  config.vm.define :lb do |lb|
    lb.vm.hostname = "lb.local"

    # Forward ports for HTTP and HTTPS traffic
    lb.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    lb.vm.network "forwarded_port", guest: 443, host: 8443, auto_correct: true
    lb.vm.network "private_network", ip: "192.168.56.20"      # Internal network
    lb.vm.network "public_network", type: "dhcp"              # NAT for internet

    lb.vm.synced_folder ".", "/myPuppetLab"

    lb.vm.provider "virtualbox" do |vb|
      vb.memory = "512"  # Adjust the memory allocation
    end
    lb.vm.provision "shell", path: "provisioners/puppetAgentInstall.sh"  
    lb.vm.provision "shell", path: "provisioners/firewalllb.sh"
    
  end
```

---

## **Tips for Optimization**

- Use lightweight base boxes (e.g., Ubuntu Server or Alpine Linux) for lower resource usage.
- Shut down unnecessary VMs when not in use:
```bash
vagrant halt vm1 vm2
```
- Monitor resource usage on your host machine to avoid overloading.
- Use dynamic storage allocation in VirtualBox to save disk space.

---

## **Troubleshooting**

### Common Issues:
1. **Virtualization Not Enabled:**
   - Ensure virtualization is enabled in the BIOS/UEFI settings.

2. **VMs Not Starting:**
   - Verify VirtualBox and Vagrant are installed correctly.
   - Check for conflicts with other hypervisors (e.g., Hyper-V on Windows).

3. **Network Connectivity Issues:**
   - Ensure all VMs are on the same private network.
   - Verify firewall rules inside VMs (e.g., using `ufw`).

---

## **Contributing**

Feel free to fork this repository and submit pull requests to improve the setup or add new features.

---

## **License**

This project is licensed under the [MIT License](LICENSE).
