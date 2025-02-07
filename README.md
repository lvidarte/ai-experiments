# ai-experiments
A repository for testing and experimenting with different AI models, frameworks, and workflows using the dom-cli tool.

---

## Installation

```bash
bin/install.sh
```

---

## Prerequisites

1. Before using the `dom` tool, you need to set up your DigitalOcean API token.  Export the `DIGITALOCEAN_TOKEN` environment variable with your token, ensuring it has the following permissions:

  - **actions**: read
  - **block_storage**: read, delete, create
  - **block_storage_action**: read, create
  - **droplet**: read, update, delete, create
  - **regions**: read
  - **sizes**: read
  - **tag**: create, read, delete
  - **ssh_key**: read

2. For connecting with your droplets, you need to export:

  - `DIGITALOCEAN_IDENTITY_FILE` with the path to the private key file.
  - `DIGITALOCEAN_KEY_ID` with your key id (Use the command `dom key list` to finds your).

---

## Current Projects

### ComfyUI

Starts an Nvidia H100 GPU droplet with [ComfyUI](https://github.com/comfyanonymous/ComfyUI) and the `models02` volume with some models.

```bash
cd comfy
./run-comfy.sh
```

Starts a minimal CPU droplet for downloading models into the `models02` volume.

```bash
cd comfy
./run-downloader.sh
```

---

## License

This project is licensed under the Apache License 2.0. See the `LICENSE` file for details.