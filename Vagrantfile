Vagrant.configure("2") do |config|
  MONGOD_HOSTS=3
  (1..MONGOD_HOSTS).each do |mongod|
    node_name = "mongod-node#{mongod}"
    config.vm.define node_name do |mongod_node|
      mongod_node.vm.box = "centos/7"
      mongod_node.vm.network "private_network", ip: "192.168.43.#{200 + mongod}"
      mongod_node.vm.hostname = node_name
      mongod_node.vm.provider :virtualbox do |vbox|
        vbox.linked_clone = true
        vbox.name = node_name
      end
      mongod_node.vm.provision :shell, path: "bash/bootstrap_avahi.sh", run: "always"
      if mongod == MONGOD_HOSTS
        mongod_node.vm.provision :ansible do |ansible|
          ansible.groups = {
            "mongod" => ["mongod-node1","mongod-node2","mongod-node3"],
          }
          ansible.limit = "all" # Connect to all machines
          ansible.playbook = "mongodb.yaml"
        end
      end
    end
  end
end
