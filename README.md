# Local Spark & Jupyter Cluster with Docker

Welcome! This project sets up a local cluster with Apache Spark and Jupyter Notebook using Docker. This guide is written for beginners and will walk you through installing, running, and understanding this configuration on your local PC.

## Prerequisites

Before starting, you need to have **Docker** installed on your PC. Docker is a platform that allows you to run applications in isolated environments called "containers".

1. **Download Docker Desktop**: Go to the [Docker website](https://www.docker.com/products/docker-desktop/) and download the installer for your operating system (Windows/Mac/Linux).
2. **Install**: Run the installer and follow the instructions. (For Windows users, ensure WSL 2 is enabled if prompted).
3. **Verify**: Open a terminal (Command Prompt or PowerShell on Windows) and run the following commands:
   ```bash
   docker --version
   docker-compose --version
   ```
   Both commands should successfully return a version number.

## Getting Started

1. **Clone the Repository**: Open your terminal and run the following commands to download this project to your PC and navigate into it:
   ```bash
   git clone https://github.com/AayushShah-904/big-data-framework
   cd big-data-framework
   ```

2. **Create the Notebooks Directory**: Before starting the cluster, manually create a folder named `notebooks`. This ensures your Jupyter notebooks are safely saved to your local PC so your work is persistent!
   ```bash
   mkdir notebooks
   ```

3. **Start the Cluster**:
   Run the following command to start all the services:
   ```bash
   docker-compose up -d
   ```
   *Note: The `-d` flag runs the cluster in the background (detached mode). The first time you run this, it will take several minutes to download all the necessary components from the internet.*

4. **Verify it's Running**:
   You can check that all services are running smoothly by typing:
   ```bash
   docker ps
   ```

## Accessing the Web Interfaces

Once the cluster is successfully running, you can monitor the different components using your web browser. Click the links below to access them:

* **Spark Master:** [http://localhost:8080](http://localhost:8080)

**To access Jupyter Notebook:**
Since Jupyter requires an authentication token on its first run, you need to grab the secure link from its logs:
1. Open your terminal and run:
   ```bash
   docker logs jupyter-spark
   ```
2. Look towards the bottom of the logs for a link that starts with `http://127.0.0.1:8888/lab?token=...`
3. **Ctrl+Click** (or Cmd+Click on Mac) that link to open it in your browser.

## Understanding Mount Volumes

In Docker, **volumes** are a way to share files between your actual computer (the "host") and the Docker containers, or to store data permanently so it isn't lost when you shut down the cluster.

If you look inside the `docker-compose.yml` file, you'll see a `volumes:` section for Jupyter. Here is what it does:

### 1. Jupyter Notebooks Mount (`./notebooks`)
- `./notebooks:/home/jovyan/work`
**Explanation**: This links the local `notebooks` folder (in the same directory as this README) to the working directory inside the Jupyter Notebook container.
**Why is this useful?** Any Python notebook (`.ipynb` file) you create or modify in the Jupyter web interface will automatically be saved into your local `notebooks` folder. This means you can easily back up your work, edit it with other tools, or push it to a GitHub repository!

## Verifying Offline Mode

Because this cluster runs entirely locally using Docker, you can work without an internet connection once the initial setup and download are complete! To verify this works:

1. **Disconnect from the Internet**: Turn off your Wi-Fi or unplug your ethernet cable.
2. **Start the Cluster**: Open your terminal and run:
   ```bash
   docker-compose up -d
   ```
   *Since Docker has already downloaded the container images during your first run, it will start them from your local cache without needing an internet connection.*
3. **Open the Web Interfaces**: You can grab your offline Jupyter link using `docker logs jupyter-spark`. The page will load instantly because `localhost` points directly to your own PC, bypassing the internet.
4. **Run a Notebook**: You can open a notebook in Jupyter and execute PySpark code entirely offline!

## Shutting Down

When you are done experimenting and want to free up your computer's memory, you can stop the cluster by running:

```bash
docker-compose down
```
*(Don't worry, this only stops the containers. Thanks to the volumes explained above, your notebooks are completely safe!)*
