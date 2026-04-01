#!/bin/bash
set -ex

# Set up Python
rm -rf /home/vscode/.uv_cache | true
mkdir /home/vscode/.uv_cache | true
uv venv --clear

# Create python symlink
mkdir -p /home/vscode/.local/bin
ln -sf /home/vscode/.local/share/uv/python/cpython-3.13.*/bin/python3 /home/vscode/.local/bin/python

# Install pre-commit hooks
if [ -f .devcontainer/requirements.txt ]; then
    uv pip install -r .devcontainer/requirements.txt
    uv run pre-commit install
fi

# Configure git...
# ...to do GPG code signing locally.
if [ "$CODESPACES" != "true" ]; then
    echo "Running locally, configure gpg."
    git config --global gpg.program gpg2
    git config --global commit.gpgsign true
else
    echo "Running in codespaces."
fi

# ...to automatically setup remote branches.
git config --global --add --bool push.autoSetupRemote true

# Woohoo!
echo "Hooray, it's done!"