#!/bin/bash
echo "=== Starting Qwen 14B Llama Server ==="
./llama.cpp/build/bin/llama-server -m ./llama.cpp/models/Qwen3-14B-Q4_K_M.gguf --port 8080 --host 0.0.0.0
