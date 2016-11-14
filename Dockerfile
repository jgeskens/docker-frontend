FROM ruby:2.3.1-alpine

RUN set -x \
    && apk add --no-cache make nodejs bash nano ruby ruby-dev gcc g++ python su-exec \
    && npm install -g yarn gulp \
    && gem install --no-rdoc --no-ri compass

ENV ROOT=/data
ENV SRC_DIR=${ROOT}/src

WORKDIR ${SRC_DIR}

COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
