inspect:
	atlas schema inspect --env local > schema/schema.hcl

apply:
	atlas schema apply --env local

diff: 
	atlas migrate diff ${file} --env gorm

migrate:
	atlas migrate apply --env local