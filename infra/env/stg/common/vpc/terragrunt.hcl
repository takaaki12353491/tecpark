include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${find_in_parent_folders("module")}/common/vpc"
}

inputs = {
  az_suffixes = ["a"]
}