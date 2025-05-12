package env_test

import (
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/takaaki12353491/tecpark/backend/common/env"
)

func TestGet(t *testing.T) {
	key := "key"
	value := "value"
	defaultValue := "default"
	os.Setenv(key, value)
	defer t.Cleanup(func() {
		os.Unsetenv(key)
	})

	cases := []struct {
		name         string
		key          string
		defaultValue string
		want         string
	}{
		{
			name:         "環境変数が設定されている場合はその値を返す",
			key:          key,
			defaultValue: defaultValue,
			want:         value,
		},
		{
			name:         "環境変数が設定されていない場合はデフォルト値を返す",
			key:          "noKey",
			defaultValue: defaultValue,
			want:         defaultValue,
		},
	}

	for _, tt := range cases {
		tt := tt
		t.Run(tt.name, func(t *testing.T) {
			t.Parallel()

			got := env.Get(tt.key, tt.defaultValue)
			assert.Equal(t, tt.want, got)
		})
	}
}
