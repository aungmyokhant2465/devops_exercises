#!/bin/bash

# Script to download a GitHub repository, build a Docker image, and publish it to Docker Hub.

# Variables
GITHUB_REPO=$1
DOCKER_IMAGE_NAME_AND_TAG=$2

# Check if all required arguments are provided
if [ -z "$GITHUB_REPO" ] || [ -z "$DOCKER_IMAGE_NAME_AND_TAG" ]; then
    echo "Usage: $0 <GitHub Repository URL> <Docker Image Name> <Docker Tag>"
    exit 1
fi

GITHUB_REPO_URL="https://github.com/$GITHUB_REPO.git"
echo "Repository URL: $GITHUB_REPO_URL"

# Clone the GitHub repository
REPO_NAME=$(basename "$GITHUB_REPO_URL" .git)
echo "Cloning the repository $GITHUB_REPO_URL..."
git clone "$GITHUB_REPO_URL"
if [ $? -ne 0 ]; then
    echo "Failed to clone the repository."
    exit 1
fi

# Change to the repository directory
cd "$REPO_NAME" || exit

# Check if Dockerfile exists
if [ ! -f "Dockerfile" ]; then
    echo "Dockerfile not found in the repository root. Exiting."
    exit 1
fi

# Build the Docker image
echo "Building the Docker image..."
docker build -t "$DOCKER_IMAGE_NAME_AND_TAG" .
if [ $? -ne 0 ]; then
    echo "Failed to build the Docker image."
    exit 1
fi

# Push the Docker image to Docker Hub
echo "Pushing the Docker image to Docker Hub..."
docker push "$DOCKER_IMAGE_NAME_AND_TAG"
if [ $? -ne 0 ]; then
    echo "Failed to push the Docker image."
    exit 1
fi

echo "Docker image successfully built and pushed to Docker Hub."
