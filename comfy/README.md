# ComfyUI 🚀

### [DOM](https://github.com/lvidarte/digitalocean-manager/) project with automations for:

1. Starts an Nvidia H100 GPU droplet with [ComfyUI](https://github.com/comfyanonymous/ComfyUI) and the `models02` volume with AI models.

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

### 1. Start the Process

Begin by starting the process. This will create a GPU droplet with the `models02` volume, which contains the AI models.

```
$ ./run-comfy.sh 
ID: 473968455, Name: comfy, Region: nyc2, Memory: 245760, VCPUs: 20, Disk: 720, Status: new, PublicIP: None
ActionID: 2502637691, Status: in-progress, Type: create, StartedAt: 2025-02-02T19:22:49Z, CompletedAt: None
ActionID: 2502637691, Status: completed, Type: create, StartedAt: 2025-02-02T19:22:49Z, CompletedAt: 2025-02-02T19:23:46Z
----------------------------------------------------------------
Droplet already created!

Droplet Name: comfy
Droplet ID:   473968455
Droplet IP:   162.243.65.216

Connect to the droplet using

ssh -i ~/.ssh/id_rsa_digitalocean root@162.243.65.216
----------------------------------------------------------------
```

### 2. Monitor the Configuration Log

Once the droplet is created, you can monitor the `config-init` log in real time.

```
Do you want to see the config-init logs? (Y/n): 
Trying ssh connection...
SSH connection established.
----------------------------------------------------------------
Showing logs from cloud-init

tail -f /var/log/cloud-init-output.log
----------------------------------------------------------------
Cloud-init v. 24.1.3-0ubuntu1~22.04.5 running 'modules:config' at Sun, 02 Feb 2025 19:24:28 +0000. Up 24.81 seconds.
Cloud-init v. 24.1.3-0ubuntu1~22.04.5 running 'modules:final' at Sun, 02 Feb 2025 19:24:33 +0000. Up 29.84 seconds.
Get:1 http://security.ubuntu.com/ubuntu jammy-security InRelease [129 kB]
(lot of system stuff here)
```

### 3. Cloud-Init Configuration

If you choose to view the cloud-init output, you will see the configuration process for Comfy begin. This includes cloning Comfy, creating symbolic links to the volume with models, setting up a virtual environment, installing necessary packages, and adding custom nodes.

```
--------------------------------------------------------
Clone ComfyUI and configure the workspace
--------------------------------------------------------
Cloning into '/app/ComfyUI'...
Creating symbolic links to the models
Creating symbolic links to the session
Downloading Art Styles csv file with 300 prompt styles
All set!
--------------------------------------------------------
Creating virtual environment
--------------------------------------------------------

(lot of python pip stuff here)

--------------------------------------------------------
Install custom nodes
--------------------------------------------------------
>>> Installing custom node from https://github.com/ltdrdata/ComfyUI-Manager.git
>>> Installing custom node from https://github.com/yolain/ComfyUI-Easy-Use.git
(output for all nodes)
```

### 4. Comfy Starts Automatically

Once the setup is complete, Comfy will start automatically.

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

   ______                ____      __  ______
  / ____/___  ____ ___  / __/_  __/ / / /  _/
 / /   / __ \/ __ `__ \/ /_/ / / / / / // /  
/ /___/ /_/ / / / / / / __/ /_/ / /_/ // /   
\____/\____/_/ /_/ /_/_/  \__, /\____/___/   
                         /____/              

Running ComfyUI v0.3.13 from master

Open http://162.243.65.216:5000 in your browser

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

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
   0.0 seconds: /app/ComfyUI/custom_nodes/ComfyUI-Easy-Use
   3.5 seconds: /app/ComfyUI/custom_nodes/ComfyUI-Manager

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
   0.0 seconds: /app/ComfyUI/custom_nodes/ComfyUI-Styles_CSV_Loader
   0.1 seconds: /app/ComfyUI/custom_nodes/ComfyUI-KJNodes
   0.1 seconds: /app/ComfyUI/custom_nodes/ComfyUI-Manager
   0.1 seconds: /app/ComfyUI/custom_nodes/ComfyUI-VideoHelperSuite
   0.5 seconds: /app/ComfyUI/custom_nodes/ComfyUI-Easy-Use
   0.6 seconds: /app/ComfyUI/custom_nodes/ComfyUI-Was-Node-Suite

Starting server

To see the GUI go to: http://0.0.0.0:5000

(You will see all the Comfy logs here.)
```

### 5. Terminate Log View (Keep Comfy Running)

Press **Ctrl+C** to terminate the connection. This will stop the real-time log output, but Comfy will continue running in the background. You can now log into the server via SSH.

```
----------------------------------------------------------------
Connect to the droplet using

ssh -i ~/.ssh/id_rsa_digitalocean root@162.243.13.216
----------------------------------------------------------------
Do you want to connect to the droplet using ssh? (Y/n): 
Welcome to Ubuntu 22.04.4 LTS (GNU/Linux 5.15.0-113-generic x86_64)

Last login: Sun Feb  2 20:04:54 2025 from 168.197.200.40
root@comfy:~#
```

### 6. Disconnect from SSH and Delete the Droplet

Press **Ctrl+C** again to disconnect from SSH. At this point, you have the option to delete the droplet.

```
Connection to 162.243.13.216 closed.
----------------------------------------------------------------
Delete the droplet using

dom droplet delete 
----------------------------------------------------------------
Do you want to delete the droplet? (Y/n):
Stopping the droplet to collect logs before deleting...
ActionID: 2503121033, Status: in-progress, Type: shutdown, StartedAt: 2025-02-03T04:46:03Z, CompletedAt: None
ActionID: 2503121033, Status: completed, Type: shutdown, StartedAt: 2025-02-03T04:46:03Z, CompletedAt: 2025-02-03T04:46:09Z
Droplet deleted.
Session ended.
```