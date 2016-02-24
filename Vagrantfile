Vagrant.configure("2") do |config|
  ENV['mem'] ||="5000"
  config.vm.box = "alvaro/kilo"
  config.vm.hostname = "devstack.local"

  config.vm.network "forwarded_port", guest: 80, host: 8888
  config.vm.network "forwarded_port", guest: 5000, host: 5555
  #config.vm.network "forwarded_port", guest: 8880, host: 8880
  #config.vm.network "forwarded_port", guest: 8881, host: 8881
  #config.vm.network "forwarded_port", guest: 8882, host: 8882
  #config.vm.network "forwarded_port", guest: 8883, host: 8883
  #config.vm.network "forwarded_port", guest: 8884, host: 8884
  #config.vm.network "forwarded_port", guest: 8885, host: 8885

  #config.vm.network "forwarded_port", guest: 8500, host: 8500

  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "#{ENV['mem']}"
    v.vmx["numvcpus"] = "2"
  end

  config.vm.provider "vmware_workstation" do |v|
    v.vmx["memsize"] = "#{ENV['mem']}"
    v.vmx["numvcpus"] = "2"
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--memory", "#{ENV['mem']}"]
  end
end


