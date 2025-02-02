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