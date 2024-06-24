# DOCKER-GUI -- ANYDESK-VNC SERVER --

## Description

This repository contains Dockerfiles for creating Docker images based on different Linux distributions, specifically Debian and Fedora. Each generated image includes a VNC (Virtual Network Computing) server and AnyDesk. These tools allow you to remotely access and control an entire Linux desktop environment from anywhere.

### VNC Server

The VNC server provides remote access to a graphical desktop environment. With VNC, you can view the remote machine's desktop in real time and control its keyboard and mouse. It is ideal for tasks that require a graphical environment and for remote management of servers or workstations.

### AnyDesk

AnyDesk is a remote access tool known for its fast and reliable performance. It allows secure remote connections and is widely used for technical support, remote administration and real-time collaboration. AnyDesk offers advanced functionalities such as file transfer, session recording, and multiple monitor support.

### Docker and Terminal GUI

These Docker images also allow connection to a Docker terminal using a graphical user interface (GUI). This makes it easier to connect remotely to a Docker terminal, providing an improved and more intuitive user experience. The GUI allows you to interact with the Docker terminal visually, making administration and usage tasks more accessible.

### Benefits of these Images

- **Consistency**: By using Docker, you can ensure that the remote desktop environment is consistent across different systems and configurations.
- **Easy to use**: These images eliminate the need to manually configure VNC and AnyDesk on each machine, saving time and reducing configuration errors.
- **Portability**: You can deploy the remote desktop environment anywhere that supports Docker, including local servers, virtual machines, and cloud services.
- **Security**: Docker provides an isolated environment, which helps protect the host system from software running in containers.
- **GUI access**: It facilitates connection to Docker terminals through a GUI, improving the user experience and simplifying remote management.

---

## Repository Content

- `Dockerfile-debian-MATE`: Dockerfile to create a Debian-based image.
- `Dockerfile-debian-XFCE`: Dockerfile to create a Debian-based image.
- `Dockerfile-fedora-LXDE`: Dockerfile to create a Fedora-based image.

## Previous requirements

- [Docker](https://www.docker.com/get-started) installed on your machine.

## Use

### Construction of Images

1. **Dockerfile**
    ```sh
    docker build -t vnc-anydesk-debian -f Dockerfile-debian .
    ```

### Ejecución de los Contenedores

1. **Debian**
    ```sh
    docker run -d -p 5901:5901 -p 7070:7070 --name vnc-anydesk-debian vnc-anydesk-debian
    ```

2. **Fedora**
    ```sh
    docker run -d -p 5902:5901 -p 7071:7070 --name vnc-anydesk-fedora vnc-anydesk-fedora
    ```

### Acceso al Entorno de Escritorio

#### VNC

Para acceder al entorno de escritorio usando VNC, puedes utilizar un cliente VNC (por ejemplo, [RealVNC](https://www.realvnc.com/en/connect/download/viewer/)) y conectarte a:

- **Debian**: `localhost:5901`
- **Fedora**: `localhost:5902`

#### AnyDesk

Para acceder utilizando AnyDesk, abre la aplicación AnyDesk y conéctate utilizando el ID que se muestra en el servidor AnyDesk en el contenedor.

## Dockerfiles

### Dockerfile-debian

```dockerfile
FROM debian:latest

# Instalación de dependencias
RUN apt-get update && apt-get install -y \
    xfce4 \
    tightvncserver \
    anydesk \
    && apt-get clean

# Configuración de VNC
RUN mkdir ~/.vnc
RUN echo "password" | vncpasswd -f > ~/.vnc/passwd
RUN chmod 600 ~/.vnc/passwd

# Copia de scripts de inicio
COPY start-vnc.sh /usr/local/bin/start-vnc.sh
COPY start-anydesk.sh /usr/local/bin/start-anydesk.sh
RUN chmod +x /usr/local/bin/start-vnc.sh
RUN chmod +x /usr/local/bin/start-anydesk.sh

# Exposición de puertos
EXPOSE 5901 7070

# Comando para iniciar VNC y AnyDesk
CMD ["sh", "-c", "/usr/local/bin/start-vnc.sh & /usr/local/bin/start-anydesk.sh & tail -f /dev/null"]
