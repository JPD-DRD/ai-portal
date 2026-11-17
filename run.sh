#!/bin/bash
echo "=== Starting Qwen 14B Llama Server ==="

# Start the server in the background
./llama.cpp/build/bin/llama-server -m ./llama.cpp/models/Qwen3-14B-Q4_K_M.gguf --port 8080 --host 0.0.0.0 &
SERVER_PID=$!

echo "=== Waiting for port 8080 to become active ==="
while ! nc -z localhost 8080; do
  sleep 1
done

echo "=== Setting port 8080 visibility to public ==="
if [ -n "$CODESPACE_NAME" ]; then
    gh codespace ports visibility 8080:public -c "$CODESPACE_NAME" && echo "Port 8080 is now Public!" || echo "CLI visibility toggle failed."
else
    echo "Not running inside a Codespace."
fi

# Keep script running with the server process
wait $SERVER_PID
