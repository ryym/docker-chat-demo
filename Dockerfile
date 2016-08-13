FROM node:4.3.2

# - Create a user to avoid executing commands as root
# - Specify npm version explicitly
RUN \
    useradd --user-group --create-home --shell /bin/false app &&\
    npm install --global npm@3.7.5

ENV HOME=/home/app

USER app
WORKDIR $HOME/chat
