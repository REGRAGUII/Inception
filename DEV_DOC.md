# Developer Documentation

## Environment Setup

### Prerequisites
- Linux Virtual Machine
- Docker installed and running
- Docker Compose
- Make
- OpenSSL

### Project Structure
- `srcs/` contains all Docker-related configuration
- `requirements/` contains one directory per service
- `secrets/` contains sensitive data ignored by Git
- `Makefile` orchestrates the build and run process

## Build and Launch
To build and start all services:
```bash
make build
```
- This command:
- Builds all Docker images
- Creates the Docker network
- Mounts volumes
- Starts containers in the correct order

## Container Management
List running containers:

```bash
docker ps
```
Stop containers:

```bash
docker compose down
```
Remove containers and volumes:

```bash
docker compose down -v
```
## Data Persistence
- MariaDB data is stored in a Docker volume mounted to /home/yregragu/data/db
- WordPress files are stored in /home/yregragu/data/wp
- Volumes ensure persistence across container restarts and rebuilds

## Configuration Files
- Environment variables are defined in .env
- Secrets are stored in the secrets/ directory
- Service-specific configuration is located under each service’s conf/ directory