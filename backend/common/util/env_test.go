package util

import (
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestGetEnv(t *testing.T) {
	key := "key"
	value := "value"
	defaultValue := "default"
	os.Setenv(key, value)
	defer os.Unsetenv(key)

	result := GetEnv(key, defaultValue)
	assert.Equal(t, value, result, "環境変数が設定されている場合、GetEnvはその値を返す")

	result = GetEnv("noKey", defaultValue)
	assert.Equal(t, defaultValue, result, "環境変数が設定されていない場合、GetEnvはデフォルト値を返す")
}
