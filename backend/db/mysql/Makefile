inspect:
	atlas schema inspect --env local > schema/tmp.hcl

apply:
	atlas schema apply --env local

diff: 
	atlas migrate diff ${file} --env gorm

migrate:
	atlas migrate apply --env local