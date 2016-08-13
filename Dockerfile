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

# Dockerはビルド時の各レイヤをキャッシュしてくれるので、
# package.json や npm-shrinkwrap.json に変更がない限り
# この RUN のレイヤはキャッシュが使われて一瞬でビルドが終わる！
# 上記いずれかのファイルに変更がある場合、その COPY 以降は
# キャッシュを使わずに新しいレイヤを作るようになる。
RUN npm install
