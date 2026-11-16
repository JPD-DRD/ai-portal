#!/bin/bash
echo "=== Starting Qwen 14B Llama Server ==="
./llama.cpp/build/bin/llama-server -m models/qwen3-14b-instruct-q4_k_m.gguf --port 8080 --host 0.0.0.0
