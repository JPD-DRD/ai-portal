#!/bin/bash
set -e

echo "=== Step 1: Installing system build essentials ==="
sudo apt-get update
sudo apt-get install -y build-essential cmake git curl

echo "=== Step 2: Cloning and building llama.cpp ==="
if [ ! -d "llama.cpp" ]; then
    git clone https://github.com/ggml-org/llama.cpp.git
fi
cd llama.cpp
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release -j$(nproc)

echo "=== Step 3: Downloading Qwen3-14B (Q4_K_M GGUF) ==="
mkdir -p models
cd models
if [ ! -f "Qwen3-14B-Q4_K_M.gguf" ]; then
    curl -L -O https://huggingface.co/unsloth/Qwen3-14B-GGUF/resolve/main/Qwen3-14B-Q4_K_M.gguf
fi
cd ../..

echo "=== Setup Complete! You are ready to launch llama-server. ==="
