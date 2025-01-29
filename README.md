# ai-experiments
A repository for testing and experimenting with different AI models, frameworks, and workflows using the dom-cli tool.

---

## Installation

```bash
bin/create_env.sh
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

---

## ComfyUI

Starts an H100 droplet machine with the models for Nvidia Cosmos

```bash
cd comfy
./run-comfy.sh
```

---

## Stability-AI / generative-models

Repo: [https://github.com/Stability-AI/generative-models](https://github.com/Stability-AI/generative-models)

For creating a droplet and run the stability-ai models

```bash
cd stability-ai
./launch-generative-models.sh
```
