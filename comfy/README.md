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

1. Install `dom` from the root of the repository:

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

---

## Comfy session example

1. Start the process. This will create the gpu droplet with the models02 volume with ai models.

```
$ ./run-comfy.sh 
ID: 473968455, Name: comfy, Region: nyc2, Memory: 245760, VCPUs: 20, Disk: 720, Status: new, PublicIP: None
ActionID: 2502637691, Status: in-progress, Type: create, StartedAt: 2025-02-02T19:22:49Z, CompletedAt: None
...
ActionID: 2502637691, Status: completed, Type: create, StartedAt: 2025-02-02T19:22:49Z, CompletedAt: 2025-02-02T19:23:46Z
----------------------------------------------------------------
Droplet already created!

Droplet Name: comfy
Droplet ID:   473968455
Droplet IP:   162.243.65.216

Connect to the droplet using

ssh -i ~/.ssh/id_rsa_digitalocean root@162.243.65.216
----------------------------------------------------------------
Do you want to see the config-init logs? (Y/n): 
Trying ssh connection...
ssh: connect to host 162.243.65.216 port 22: Connection refused
Waiting for the droplet to be ready for ssh connections...
The authenticity of host '162.243.65.216 (162.243.65.216)' can't be established.
ED25519 key fingerprint is SHA256:abl8NF0eUBV3FSPWMIVx34Hr+u+DkChOGmpIuueUp/c.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '162.243.65.216' (ED25519) to the list of known hosts.
SSH connection established.
----------------------------------------------------------------
Showing logs from cloud-init

tail -f /var/log/cloud-init-output.log
----------------------------------------------------------------
|              + o|
|         o . + . |
|        S + + .  |
| . . . = + + .   |
|o + o = + . o .  |
|.o.=.. . . . . . |
|.++. .E     ..oo.|
+----[SHA256]-----+
Cloud-init v. 24.1.3-0ubuntu1~22.04.5 running 'modules:config' at Sun, 02 Feb 2025 19:24:28 +0000. Up 24.81 seconds.
Cloud-init v. 24.1.3-0ubuntu1~22.04.5 running 'modules:final' at Sun, 02 Feb 2025 19:24:33 +0000. Up 29.84 seconds.
Get:1 http://security.ubuntu.com/ubuntu jammy-security InRelease [129 kB]
...
(more system stuff here)
```

2. Cloud config for Comfy begins (clone Comfy, create symbolic links to volume with models, virtual environment creation, package installation, custom nodes installation, etc.)

```
--------------------------------------------------------
Clone ComfyUI and create symbolic links
--------------------------------------------------------
Cloning into '/app/ComfyUI'...
--------------------------------------------------------
Creating virtual environment
--------------------------------------------------------
Requirement already satisfied: pip in ./.env/lib/python3.10/site-packages (22.0.2)
Collecting pip
  Downloading pip-25.0-py3-none-any.whl (1.8 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.8/1.8 MB 36.9 MB/s eta 0:00:00
Installing collected packages: pip
  Attempting uninstall: pip
    Found existing installation: pip 22.0.2
    Uninstalling pip-22.0.2:
      Successfully uninstalled pip-22.0.2
Successfully installed pip-25.0
Looking in indexes: https://pypi.org/simple, https://download.pytorch.org/whl/cu121
Collecting torch
  Downloading torch-2.6.0-cp310-cp310-manylinux1_x86_64.whl.metadata (28 kB)
...
(lot of stuff here)
...
--------------------------------------------------------
Install custom nodes
--------------------------------------------------------
>>> Install ComfyUI-Manager
Cloning into 'ComfyUI-Manager'...
Collecting GitPython (from -r requirements.txt (line 1))
  Downloading GitPython-3.1.44-py3-none-any.whl.metadata (13 kB)
...
(install all nodes)
```

3. Finally, Comfy starts

```
--------------------------------------------------------
Running ComfyUI v0.3.13 from master

Open http://162.243.65.216:5000 in your browser
--------------------------------------------------------
[START] Security scan
[DONE] Security scan
## ComfyUI-Manager: installing dependencies done.
** ComfyUI startup time: 2025-02-02 19:27:09.164
** Platform: Linux
** Python version: 3.10.12 (main, Jan 17 2025, 14:35:34) [GCC 11.4.0]
** Python executable: /app/ComfyUI/.env/bin/python3
** ComfyUI Path: /app/ComfyUI
** ComfyUI Base Folder Path: /app/ComfyUI
** User directory: /app/ComfyUI/user
** ComfyUI-Manager config path: /app/ComfyUI/user/default/ComfyUI-Manager/config.ini
** Log path: /app/ComfyUI/user/comfyui.log

Prestartup times for custom nodes:
   3.4 seconds: /app/ComfyUI/custom_nodes/ComfyUI-Manager

Checkpoint files will always be loaded safely.
Total VRAM 81008 MB, total RAM 241608 MB
pytorch version: 2.6.0+cu124
Set vram state to: NORMAL_VRAM
Device: cuda:0 NVIDIA H100 80GB HBM3 : cudaMallocAsync
Using pytorch attention
ComfyUI version: 0.3.13
[Prompt Server] web root: /app/ComfyUI/web
Total VRAM 81008 MB, total RAM 241608 MB
pytorch version: 2.6.0+cu124
Set vram state to: NORMAL_VRAM
Device: cuda:0 NVIDIA H100 80GB HBM3 : cudaMallocAsync
### Loading: ComfyUI-Manager (V3.17.6)
### ComfyUI Version: v0.3.13-9-g44e19a28 | Released on '2025-02-02'

Import times for custom nodes:
   0.0 seconds: /app/ComfyUI/custom_nodes/websocket_image_save.py
   0.1 seconds: /app/ComfyUI/custom_nodes/ComfyUI-KJNodes
   0.1 seconds: /app/ComfyUI/custom_nodes/ComfyUI-Manager
   0.1 seconds: /app/ComfyUI/custom_nodes/ComfyUI-VideoHelperSuite

Starting server

To see the GUI go to: http://0.0.0.0:5000
```

You will see all the Comfy logs here.

4. Ctrl-C will stop Comfy. Now you will have a chance to login into the server via ssh:

```
----------------------------------------------------------------
Connect to the droplet using

ssh -i ~/.ssh/id_rsa_digitalocean root@162.243.13.216
----------------------------------------------------------------
Do you want to connect to the droplet using ssh? (Y/n): 
Welcome to Ubuntu 22.04.4 LTS (GNU/Linux 5.15.0-113-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Sun Feb  2 20:35:17 UTC 2025

  System load:  0.19               Processes:             278
  Usage of /:   3.3% of 697.62GB   Users logged in:       0
  Memory usage: 3%                 IPv4 address for eth0: 162.243.13.216
  Swap usage:   0%                 IPv4 address for eth0: 10.13.0.5

Expanded Security Maintenance for Applications is not enabled.

131 updates can be applied immediately.
53 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

9 additional security updates can be applied with ESM Apps.
Learn more about enabling ESM Apps service at https://ubuntu.com/esm

New release '24.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Sun Feb  2 20:04:54 2025 from 168.197.200.40
root@comfy:~#
```

5. Ctrl-C will stop the ssh connection. Now you will have the chance to delete the droplet.

```
Connection to 162.243.13.216 closed.
----------------------------------------------------------------
Delete the droplet using

dom droplet delete 
----------------------------------------------------------------
Do you want to delete the droplet? (Y/n): 
Droplet deleted.
Session ended.
```