FROM node:4.3.2

# - Create a user to avoid executing commands as root
# - Specify npm version explicitly
RUN \
    useradd --user-group --create-home --shell /bin/false app &&\
    npm install --global npm@3.7.5

ENV HOME=/home/app

COPY package.json npm-shrinkwrap.json $HOME/chat/

# https://github.com/docker/docker/issues/6119
RUN chown -R app:app $HOME/*

USER app
WORKDIR $HOME/chat
RUN npm install
