data "external_schema" "gorm" {
  program = [
    "go",
    "run",
    "ariga.io/atlas-provider-gorm",
    "load",
    "--path", "../../common/domain/model",
    "--dialect", "mysql"
  ]
}

env "gorm" {
  src = data.external_schema.gorm.url
  dev = "docker://mysql/8/dev"

  migration {
    dir = "file://migrations"
  }

  format {
    migrate {
      diff = "{{ sql . \"  \" }}"
    }
  }
}

env "local" {
  src = "file://schema.hcl"
  url = "mysql://root:root@localhost:23306/tecpark"
  dev = "docker://mysql/8/dev"
}