#!/bin/bash

# Define variables for AWS Account ID and Region
AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID:-"your-default-account-id"}
AWS_REGION=${AWS_REGION:-"your-default-region"}
REPO_NAME="powershell-modules-aws-tools"

# Validate that AWS_ACCOUNT_ID and AWS_REGION are set
if [ -z "$AWS_ACCOUNT_ID" ] || [ -z "$AWS_REGION" ]; then
  echo "Error: AWS_ACCOUNT_ID and AWS_REGION must be set."
  exit 1
fi

# Create the ECR repository if it doesn't already exist
aws ecr describe-repositories --repository-names "$REPO_NAME" --region "$AWS_REGION" --no-paginate >/dev/null 2>&1 || \
aws ecr create-repository --repository-name "$REPO_NAME" --region "$AWS_REGION"

# Build and push the Docker image
IMAGE_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}:latest"
docker build -t "$IMAGE_URI" .
docker push "$IMAGE_URI"
