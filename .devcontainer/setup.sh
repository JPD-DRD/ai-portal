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

echo "=== Step 3: Downloading Qwen 2.5 14B Instruct (GGUF) ==="
mkdir -p models
cd models
if [ ! -f "qwen2.5-14b-instruct-q4_k_m.gguf" ]; then
    curl -L -O https://huggingface.co/Qwen/Qwen2.5-14B-Instruct-GGUF/resolve/main/qwen2.5-14b-instruct-q4_k_m.gguf
fi
cd ../..

echo "=== Setup Complete! You are ready to launch llama-server. ==="
