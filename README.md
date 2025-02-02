# ai-experiments
A repository for testing and experimenting with different AI models, frameworks, and workflows using the dom-cli tool.

---

## Installation

```bash
bin/install.sh
```

---

## Prerequisites

Before using the `dom` tool, you need to set up your DigitalOcean API token.  
Export the `DIGITALOCEAN_TOKEN` environment variable with your token, ensuring it has the following permissions:

- **actions**: read
- **block_storage**: read, delete, create
- **block_storage_action**: read, create
- **droplet**: read, update, delete, create
- **regions**: read
- **sizes**: read
- **tag**: create, read, delete
- **ssh_key**: read

Also, for connecting with your droplets, you need to export the `DIGITALOCEAN_IDENTITY_FILE` with the path to the private key file.

---

## ComfyUI

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
