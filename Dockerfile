##################################################################################
# Utiliser une image de base Debian
FROM debian:latest

##################################################################################
# Mettre à jour les packages #
##############################
RUN apt update && apt full-upgrade -y

##################################################################################
# Installer Cinnamon et les dépendances #
#########################################
RUN apt install -y cinnamon-desktop-environment

##################################################################################
# Configurer le gestionnaire de fenêtres #
##########################################
RUN update-alternatives --set x-session-manager /usr/bin/cinnamon-session

##################################################################################
# Installer noVNC #
###################
RUN apt install -y novnc

##################################################################################
# Installer logiciel #
######################
RUN apt install -y libreoffice
RUN apt install -y firefox-esr

##################################################################################
# Créer le fichier ~/.xinitrc #
###############################
RUN echo "exec cinnamon-session" >> ~/.xinitrc


##################################################################################
# Definir Utilisateur #
#######################
ARG PUID
ARG PGID

ENV PUID=${PUID}
ENV PGID=${PGID}

RUN chown -R ${PUID}:${PGID} /home/marc

##################################################################################
# Définir le répertoire de travail par défaut #
###############################################
WORKDIR /home/marc

##################################################################################
# Créer un volume pour les données utilisateurs #
#################################################
VOLUME /home/marc/

##################################################################################
# Exposer le port 8888 pour VNC Web #
#####################################
EXPOSE 8888

##################################################################################
# Lancer Xinit lors du démarrage du conteneur #
###############################################
CMD ["xinit", "--", "novnc", "--listen", "8888"]
