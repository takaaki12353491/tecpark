package test

import (
	"common/util"

	"gorm.io/gorm"
)

type TestContext struct {
	TX             *gorm.DB
	SavePointStack util.Stack[string]
}

func NewTestContext(db *gorm.DB) *TestContext {
	return &TestContext{
		TX:             db,
		SavePointStack: util.Stack[string]{},
	}
}
