---
title: "uv tips"
date: 2025-07-21
til: true
tags: []
---

Today I learned about some powerful, lesser-known features of [uv](https://docs.astral.sh/uv/guides/), a fast Python package and environment manager. Beyond the usual `uv venv` and `uv sync`, uv offers commands that streamline workflows for tool management, Python versions, and reproducible builds. Here’s a quick overview of some standout features:

### Running ruff directly
```bash
# Install CLI tools globally in isolated environments (like pipx, but faster)
uv tool install ruff
# Run tools ephemerally without permanent installs
uvx ruff check
```

### Manage Python versions directly
```bash
# Install specific Python versions
uv python install 3.10 3.11
# List installed versions
uv python list
# Upgrade to latest patch release
uv python upgrade 3.10
```

### Compile requirements for reproducible builds
```bash
# Generate a pinned lockfile
uv pip compile requirements.in -o requirements.txt --universal
# Pre-compile bytecode for faster container startup
uv pip compile requirements.in -o requirements.txt --compile-bytecode
```

### Run commands with automatic environment syncing
```bash
# Auto-sync dependencies before running
uv run ruff check
# Use non-editable installs for production-like setups
uv run --no-editable python script.py
```

### Build and package Python distributions
```bash
# Create source distribution and wheel
uv build --wheel
# Skip build isolation for tricky dependencies
uv build --no-build-isolation-package numpy
```

I have really liked using uv in my work and personal projects. It's no secret it is becoming the best way to manage Python dependencies. Knowing some of the other things uv can do helps make developing in Python that much more enjoyable.

Check the [uv docs](https://docs.astral.sh/uv/guides/) for more details.