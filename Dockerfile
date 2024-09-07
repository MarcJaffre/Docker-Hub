# Utilisation de l'image officielle de Ubuntu comme base
FROM ubuntu:latest

# Installation d'Apache2
RUN apt-get update && apt-get install -y apache2

# Exposition du port 80 pour accéder au serveur web
EXPOSE 80

# Définition du répertoire de travail
WORKDIR /var/www/html

# Copie du contenu du répertoire courant dans le conteneur
COPY . /var/www/html/

# Commande pour démarrer le serveur Apache2
CMD ["apachectl", "-D", "FOREGROUND"]
