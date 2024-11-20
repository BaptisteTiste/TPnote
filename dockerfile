# Utiliser une image Node.js comme base (version adaptée à Wiki.js)
FROM node:16

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Installer wget pour télécharger Wiki.js
RUN apt-get update && apt-get install -y wget && apt-get clean

# Télécharger et extraire Wiki.js
RUN wget https://github.com/Requarks/wiki/releases/latest/download/wiki-js.tar.gz && \
    mkdir wiki && \
    tar xzf wiki-js.tar.gz -C ./wiki

# Changer de répertoire vers "wiki"
WORKDIR /app/wiki

# Renommer le fichier de configuration par défaut
RUN mv config.sample.yml config.yml

# Rebuild du module SQLite3
RUN npm rebuild sqlite3

# Exposer le port utilisé par Wiki.js
EXPOSE 3000

# Commande par défaut pour démarrer Wiki.js
CMD ["node", "server"]
