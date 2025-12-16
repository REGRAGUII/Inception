# User Documentation

## Overview
This project provides a secure WordPress website deployed using Docker containers.
The stack includes NGINX, WordPress, and MariaDB.

## Provided Services
- Secure HTTPS web server (NGINX)
- WordPress website
- MariaDB database backend

## Starting the Project
From the project root:
```bash
make build
```
## Stopping the Project
```bash
make clean
```
## Accessing the Website
Open a browser and go to:
```bash
https://yregragu.42.fr
```
## WordPress Administration
Access the admin panel at:
```bash
https://yregragu.42.fr/wp-admin
```
Use the credentials defined during the WordPress setup.

## Credentials Management
Credentials are stored using environment variables and Docker secrets
No passwords are hard-coded in Dockerfiles

## Checking Services Status
```bash
docker ps
```
To inspect logs:
```bash
docker logs <container_name>
```
## Data Persistence
WordPress files and database data persist even after container restarts
Data is stored inside Docker volumes mapped to the host