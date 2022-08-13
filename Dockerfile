FROM fluent/fluentd:v1.14.6-1.1
LABEL maintainer "Allan Olweny <allan.olweny+github@gmail.com"

USER root

RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install fluent-plugin-elasticsearch \
        fluent-plugin-rewrite-tag-filter \
        fluent-plugin-detect-exceptions \
        fluent-plugin-forest \
        fluent-plugin-record-reformer \
        fluent-plugin-docker_metadata_elastic_filter \
        fluent-plugin-filter_typecast \
        fluent-plugin-filter_empty_keys \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /home/fluent/.gem/ruby/2.5.0/cache/*.gem

ADD https://raw.githubusercontent.com/fluent/fluentd-docker-image/master/v1.14/alpine/entrypoint.sh /bin/

RUN chmod 555 /bin/entrypoint.sh

USER fluent