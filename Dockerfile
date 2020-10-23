FROM node:8-alpine

RUN set -x \
    && apk add --no-cache make bash nano gcc g++ su-exec python curl gettext yarn \
    && curl -Ls "https://github.com/dustinblackman/phantomized/releases/download/2.1.1/dockerized-phantomjs.tar.gz" | tar xz -C / \
    && npm install -g gulp

ENV ROOT=/data
ENV SRC_DIR=${ROOT}/src

WORKDIR ${SRC_DIR}

COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
