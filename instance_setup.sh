#!/bin/bash
sudo yum update

#   Set Docker images to pull from Docker hub
docker pull {image_name}:{version_tag}

#   Run the Docker on a specific port
docker run -d -p PORT:PORT {image_name}:{version_tag}