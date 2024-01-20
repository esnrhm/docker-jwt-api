# Authentication through JWT in the Docker API.

To enable authentication in your small-scale applications through Docker API, it is recommended to simplify the implementation by utilizing an authentication method other than the default Docker approach. In this project, the use of Nginx proxy capabilities and Lua scripting has been employed to authenticate and forward all Docker API functionalities based on a username and password. The goal is to streamline the authentication process and route requests towards the Docker engine
## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Usage](#usage)
- [API Authentication](#api-authentication)
- [Docker Compose Configuration](#docker-compose-configuration)
- [Example Requests](#example-requests)
- [Resources](#resources)
- [License](#License)


## Introduction

Provide a short introduction to your project, explaining its purpose and key features.

## Prerequisites

Make sure you have the following software installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/esnrhm/docker-jwt-api.git
   cd docker-jwt-api
   ```

2. Build the Docker image:

   ```bash
   docker-compose build
   ```

### Usage

Start the project:

```bash
docker-compose up -d
```

The project should now be accessible at `http://127.0.0.1:2376`.

## API Authentication

To authenticate API requests, use the following command to obtain a token:

```bash
curl 127.0.0.1:2376/login -d '{"username":"your_username","password":"your_password"}'
```

The response will contain an authentication token that you can use in subsequent requests.

## Docker Compose Configuration

Adjust the environment variables in the `docker-compose.yml` file to customize authentication credentials and other settings.

```yaml
# Edit the following lines in the docker-compose.yml file
environment:
 - USERNAME=admin
 - PASSWORD=admin
 - SECRET_KEY="your_secret_key"
```

## Example Requests

Once authenticated, you can make API requests using the obtained token:

```bash
curl 127.0.0.1:2376/info -H "Authorization: your_token_here"
```

## Resources

- [nginx](https://www.nginx.com/)
- [lua](https://www.lua.org/)
- [nginx-lua](https://github.com/fabiocicerchia/nginx-lua)



## License

This project is licensed under the MIT.
