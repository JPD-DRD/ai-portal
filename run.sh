#!/bin/bash
echo "=== Starting Qwen 14B Llama Server ==="

# Start the server in the background
./llama.cpp/build/bin/llama-server -m ./llama.cpp/models/Qwen3-14B-Q4_K_M.gguf --port 8080 --host 0.0.0.0 &
SERVER_PID=$!

echo "=== Automatically setting port 8080 visibility to public ==="
sleep 4

# Automatically change port 8080 visibility using GitHub CLI
if [ -n "$CODESPACE_NAME" ]; then
    gh codespace ports visibility 8080:public -c "$CODESPACE_NAME" 2>/dev/null && echo "Port 8080 is now Public!" || echo "CLI visibility toggle skipped."
else
    echo "Not running inside a Codespace. Skipping CLI command."
fi

# Keep the script running with the background server process
wait $SERVER_PID
