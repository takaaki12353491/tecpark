data "external_schema" "gorm" {
  program = [
    "go",
    "run",
    "-mod=mod",
    "ariga.io/atlas-provider-gorm",
    "load",
    "--path", "../../backend/user/domain/model",
    "--dialect", "mysql"
  ]
}

env "gorm" {
  src = data.external_schema.gorm.url
  url = "mysql://tecpark:tecpark@localhost:23306/tecpark"
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
