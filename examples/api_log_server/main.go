package main

import (
	"fmt"
	"io"
	"net/http"
	"os"

	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

func main() {
	// Setup zerolog logger
	log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stdout})

	// Handle any route
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		// Read request body
		body, err := io.ReadAll(r.Body)
		if err != nil {
			log.Error().Err(err).Msg("Error reading request body")
			http.Error(w, "Internal Server Error", http.StatusInternalServerError)
			return
		}
		// Log the request details
		log.Info().
			Str("method", r.Method).
			Str("path", r.URL.Path).
			Str("body", string(body)).
			Msg("Received request")

		// Send a response
		fmt.Fprintln(w, "{}")
	})

	// Start the server
	log.Info().Msg("Starting server on http:0.0.0.0:8000, see: http://127.0.0.1:8000")
	if err := http.ListenAndServe(":8000", nil); err != nil {
		log.Fatal().Err(err).Msg("Server failed to start")
	}
}
