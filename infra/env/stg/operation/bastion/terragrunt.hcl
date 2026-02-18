include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/operation/bastion"
}

dependency "network" {
<<<<<<< HEAD
  config_path = "${find_in_parent_folders("github.com/takaaki12353491/tecpark/backend/common")}/network"
=======
  config_path = "${find_in_parent_folders("common")}/network"
>>>>>>> 43b153f (Merge pull request #91 from takaaki12353491/fix/infra)
}

inputs = {
  main_vpc_id        = dependency.network.outputs.main_vpc_id
  azs                = dependency.network.outputs.azs
  private_cidrs      = dependency.network.outputs.private_cidrs
  private_subnet_ids = dependency.network.outputs.private_subnet_ids
}
