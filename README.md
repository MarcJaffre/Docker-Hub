[![Docker Image CI](https://github.com/MarcJaffre/automaker/actions/workflows/docker-image.yml/badge.svg?branch=main)](https://github.com/MarcJaffre/automaker/actions/workflows/docker-image.yml)


# Présentation
```
Construire une Image Docker depuis un Github
```

# Guide
```
- Se connecter sur Docker-Hub
- Générer un Token
- Crée un Dépôt Docker-hub (dexter74/cinnamon)
- Création du Dépôt Git-Hub
- Ajout du secret (Settings > Actions > New Repository Secrets)
 - DOCKER_HUB_USERNAME = XXXXXXXX
 - DOCKER_HUB_TOKEN
- Création d'un Dockerfile
- Création d'un fichier .dockerignore qui exclus les fichiers, dossiers lors de la construction.
- Création d'une Actions (Docker Image)
- Copier le code
- Lancement de la construction
```


# Workflow
```
###########################################################################
name: Docker Image CI #
#######################

###########################################################################
on:                                                                       #
  # --------------------------------------------------------------------- #
  push:                                                                   #
    branches: [ "main" ]                                                  #
  # --------------------------------------------------------------------- #
  pull_request:                                                           #
    branches: [ "main" ]                                                  #
  # --------------------------------------------------------------------- #
###########################################################################
#
#
###########################################################################
jobs:                                                                     #
  # --------------------------------------------------------------------- #
  build:                                                                  #
  # --------------------------------------------------------------------- #
    runs-on: debian-latest                                                #
    # ------------------------------------------------------------------- #
    steps:                                                                #
    -                                                                     #
     name: Checkout code                                                  #
     uses: actions/checkout@v4                                            #
    # ------------------------------------------------------------------- #
    -                                                                     #
     name: Login to Docker Hub                                            #
     uses: docker/login-action@v3                                         #
     with:                                                                #
      username: ${{ secrets.DOCKER_HUB_USERNAME }}                        #
      password: ${{ secrets.DOCKER_HUB_TOKEN }}                           #
    # ------------------------------------------------------------------- #
    -                                                                     #
     name: Build the Docker image                                         #
     run: docker build . -t cinnamon-desktop                              #
    # ------------------------------------------------------------------- #
    -                                                                     #
     name: Push the Docker image                                          #
     uses: docker/build-push-action@v6                                    #
     with:                                                                #
      push: true                                                          #
      tags: ${{ secrets.DOCKER_HUB_USERNAME }}/cinnamon:latest            #
    # ------------------------------------------------------------------- #
###########################################################################
```
