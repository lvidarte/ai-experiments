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

Starts an H100 droplet machine with ComfyUI and the `models02` volume with some models.

```bash
cd comfy
./run-comfy.sh
```

Starts an minimal cpu droplet for uploading models to the `models02` volume.

```bash
cd comfy
./run-uploader.sh
```
