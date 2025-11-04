# Vagrantfile - Taller Vagrant con 2 máquinas: web y db
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"  # Ubuntu 20.04 LTS

  # Shared folder: sincroniza ./www -> /vagrant_data (en guest)
  config.vm.synced_folder "./www", "/vagrant_data", owner: "vagrant", group: "vagrant"

  # Máquina web
  config.vm.define "web" do |web|
    web.vm.hostname = "web.local"
    web.vm.network "private_network", ip: "192.168.56.10"
    web.vm.provider "virtualbox" do |vb|
      vb.name = "vagrant-web"
      vb.memory = 1024
      vb.cpus = 1
    end
    web.vm.provision "shell", path: "provision-web.sh"
  end

  # Máquina db
  config.vm.define "db" do |db|
    db.vm.hostname = "db.local"
    db.vm.network "private_network", ip: "192.168.56.11"
    db.vm.provider "virtualbox" do |vb|
      vb.name = "vagrant-db"
      vb.memory = 512
      vb.cpus = 1
    end
    db.vm.provision "shell", path: "provision-db.sh"
  end
end
