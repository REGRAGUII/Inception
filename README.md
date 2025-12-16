*This project has been created as part of the 42 curriculum by yregragu.*

# Inception


## Description
Inception is a system administration project aimed at introducing students to modern infrastructure deployment practices using Docker.
The goal is to set up a secure and modular web hosting environment by containerizing different services and managing them with Docker Compose.

The entire setup is deployed inside a virtual machine, simulating a production-like environment.
Each core service (web server, database, application) runs in its own isolated Docker container,
ensuring separation of concerns, scalability, and maintainability.

The infrastructure includes:
- NGINX web server with TLSv1.2 or TLSv1.3.
- WordPress application running with PHP-FPM.
- MariaDB database server.
- Volumes for WordPress database and website files
- Docker network to isolate inter-service communication

All services are built from custom Dockerfiles based on Debian image and are orchestrated using Docker Compose.

## Instructions

### Requirements
- Linux-based Virtual Machine
- Docker
- Docker Compose
- Make
- OpenSSL

### Build and Run
From the root of the project:
    make build : would make images and run the containers.
    make clean : to stop and clean the infrastructure.
    make fclean : to remove all containers, images, and volumes.

## Resources
- Docker documentation: https://docs.docker.com/
- Docker Compose documentation: https://docs.docker.com/compose
- NGINX documentation: https://nginx.org/en/docs
- WordPress documentation: https://wordpress.org/support
- MariaDB documentation: https://mariadb.org/documentation

### Use of AI

    AI tools were used to assist with:
        Understanding Docker concepts
        Structuring documentation
        Reducing repetitive tasks
        All generated content was reviewed, understood, and adapted before integration.

## Project Description
###    Project Architecture

-NGINX listens on port 443 and handles TLS termination
-WordPress communicates with PHP-FPM internally
-MariaDB stores WordPress data
-Containers communicate through a private Docker network
-Data persistence is ensured using Docker volumes mounted on the host

### Technical Choices and Comparisons
#### Virtual Machines vs Docker

    -Virtual Machines virtualize hardware and include a full operating system
    -Docker containers virtualize only the application and its dependencies
    -Docker is lighter, faster to start, and more resource-efficient

#### Secrets vs Environment Variables

    -Environment variables are used for non-sensitive configuration
    -Secrets are used to store sensitive data such as database passwords
    -Secrets prevent credentials from being exposed in Dockerfiles or Git repositories

### Docker Network vs Host Network

    -Docker networks provide isolation between containers
    -The host network is avoided to prevent security risks
    -Inter-container communication is handled internally via Docker DNS

### Docker Volumes vs Bind Mounts

    -Volumes are managed by Docker and are portable and secure
    -Bind mounts depend on host paths and are less flexible
    -Volumes are used to ensure persistent and reliable data storage