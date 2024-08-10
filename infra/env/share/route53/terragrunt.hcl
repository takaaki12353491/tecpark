include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "./"
}

inputs = {
  domain = get_env("DOMAIN", "tecpark.net")

  stg_name_servers = [
    "ns-1471.awsdns-55.org.",
    "ns-351.awsdns-43.com.",
    "ns-1936.awsdns-50.co.uk.",
    "ns-667.awsdns-19.net."
  ]
}
