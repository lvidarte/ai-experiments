# ComfyUI

### [DOM](https://github.com/lvidarte/digitalocean-manager/) project with automations for:

1. Starts an Nvidia H100 GPU droplet with [ComfyUI](https://github.com/comfyanonymous/ComfyUI) and the `models02` volume with some models.

```bash
./run-comfy.sh
```

2. Starts a minimal CPU droplet for downloading models into the `models02` volume.

```bash
./run-downloader.sh
```

---

## Prerequisites

1. Install dom from the root of the repository:

```bash
bin/install.sh
```

2. For using the `dom` tool, you need to set up your DigitalOcean API token. Export the `DIGITALOCEAN_TOKEN` environment variable with your token, ensuring it has the following permissions:

  - **actions**: read
  - **block_storage**: read, delete, create
  - **block_storage_action**: read, create
  - **droplet**: read, update, delete, create
  - **regions**: read
  - **sizes**: read
  - **tag**: create, read, delete
  - **ssh_key**: read

3. For connecting with your droplets, you need to export:

  - `DIGITALOCEAN_IDENTITY_FILE` with the path to the private key file (Used by ssh).
  - `DIGITALOCEAN_KEY_ID` with your key id (Use the command `dom key list` to finds your).