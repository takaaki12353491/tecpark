include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/common/network"
}

inputs = {
  az_suffixes = ["a"]
}
