# -*- mode: ruby -*-
# vi: set ft=ruby :

CONFIG_VERSION = 2
Vagrant.configure(CONFIG_VERSION) do |config|

  # Copy this loop to create more VMs.
  config.vm.define "jackinthebox-django", primary: true do |config_local|

    # Search for alternative boxes here: https://app.vagrantup.com/boxes/search.
    config_local.vm.box = "bento/ubuntu-16.04"

    # If false: Would mean you need to run `vagrant box outdated` to update the box.
    config_local.vm.box_check_update = true

    # Forward VM port 80 to local machine port 80 via IP 127.0.0.1.
    config_local.vm.network :forwarded_port, guest: 80, host: 8080, host_ip: "127.0.0.1"

    # Share an additional folder to the guest VM.
    config_local.vm.synced_folder "./box/app", "/vagrant/app", :mount_options => ['dmode=777', 'fmode=666']
    config_local.vm.synced_folder "./box/app", "/var/www/app", :mount_options => ['dmode=777', 'fmode=666']
    config_local.vm.synced_folder "./box/provisioning", "/vagrant/provisioning", :mount_options => ['dmode=777', 'fmode=666']

    config_local.vm.provider "virtualbox" do |vb|
      # Identifer for this VM.
      vb.name = "jackinthebox-django"

      # Display the VirtualBox GUI when booting the machine.
      vb.gui = false

      # Customize the amount of memory on the VM.
      vb.memory = "8192"

      # Customize the amount of video memory on the VM.
      vb.customize ["modifyvm", :id, "--vram", "128"]

      # Put VMs in a virtualbox group.
      vb.customize ["modifyvm", :id, "--groups", "/jackinthebox"]

      # Set the monitor count from the environment.
      monitorCount = ENV['monitorcount'] || "1"
      vb.customize ["modifyvm", :id, "--monitorcount", monitorCount]
    end


    # 'provision' using Ansible, i.e. install/setup the VM's tools.
    config_local.vm.provision "ansible_local" do |ansible_local|

      # Install ansible onto the VM
      ansible_local.install = true

      # Paths to provisioning files.
      ansible_local.provisioning_path = "/vagrant/box/provisioning/"
      ansible_local.playbook = "playbook.yml"

      # Remove if you have problems.
      ansible_local.compatibility_mode = "2.0"

      # Set verbosity
      ansible_local.verbose = true
      
    end

  end

end
