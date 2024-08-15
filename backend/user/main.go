package main

import (
	"encoding/json"
	"log"
	"net/http"
	"strings"
)

type Response struct {
	Message string `json:"message"`
}

func handler(w http.ResponseWriter, r *http.Request) {
	log.Printf("アクセスがありました: %s %s", r.Method, r.URL.Path)
	response := Response{Message: "Hello, World!"}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func corsMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		origin := r.Header.Get("Origin")
		if origin != "" && isAllowedOrigin(origin) {
			w.Header().Set("Access-Control-Allow-Origin", origin)
		}
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")
		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}
		next.ServeHTTP(w, r)
	})
}

// サブドメインとルートドメインをチェックする関数
func isAllowedOrigin(origin string) bool {
	allowedDomain := "stg.tecpark.net"
	// サブドメインもしくはルートドメインが一致するかどうかをチェック
	return origin == "http://"+allowedDomain || origin == "https://"+allowedDomain || strings.HasSuffix(origin, "."+allowedDomain)
}

func main() {
	log.Println("サーバーが起動しました。ポート: 80")
	http.Handle("/", corsMiddleware(http.HandlerFunc(handler)))
	http.ListenAndServe(":80", nil)
}
