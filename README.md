# Dev Container Environments

This repository contains reusable development container environments. These standardise environments ensuring consistency across the development team, while providing the flexibility needed by individuals.

## Included Containers
### [Full Stack Development](fullstack/)
Features:
- **Languages:** Python 3.13, Go 1.26.1.
- **Python Packager:** `uv` handles Python packages natively.
- **Go Support:** Incorporates Go utilities and static analysis tools.
- **Automation:** Uses `Taskfile` over `Makefile` for configuration definition without dependency graphs.
- **Platform Features**: Docker in Docker features are available.

## Usage
Simply define `.devcontainer/devcontainer.json` within your project, targeting the selected standard from this repository:
```json
{
  "name": "project_name",
  "build": {
    "dockerfile": "../path/to/repo/fullstack/.devcontainer/Dockerfile",
    "context": "../path/to/repo"
  }
}
```
Replace `../path/to/repo/fullstack/` with the relative path from the project directory to where you've cloned this repository.

> **Note:** These examples provide generic base configurations; tailor as your team's stack dictates.
