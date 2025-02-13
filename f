name: Build a Docker image and Push it to ACR

on:
  push:
    branches: [ main ]
    paths:
      - $GITHUB_WORKSPACE/content-web
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - uses: azure/docker-login@v1
        with:
          login-server: fabmedicalmds.azurecr.io
          username: ${{ secrets.ACR_USERNAME }}
          password: ${{ secrets.ACR_PASSWORD }}

      - run: |
        docker build "$GITHUB_WORKSPACE/content-api" -f  "content-api/Dockerfile" -t fabmedicalmds.azurecr.io/content-api:${{ github.sha }} 
        docker push fabmedicalmds.azurecr.io/content-api:${{ github.sha }}
        docker build "$GITHUB_WORKSPACE/content-web" -f  "content-web/Dockerfile" -t fabmedicalmds.azurecr.io/content-web:${{ github.sha }} 
        docker push fabmedicalmds.azurecr.io/content-web:${{ github.sha }}
        docker build "$GITHUB_WORKSPACE/content-init" -f  "content-init/Dockerfile" -t fabmedicalmds.azurecr.io/content-init:${{ github.sha }} 
        docker push fabmedicalmds.azurecr.io/content-init:${{ github.sha }}
