FROM fluent/fluentd:v1.10-1
MAINTAINER YOUR_NAME <...@...>

USER root

RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 # cutomize following instruction as you wish
 && sudo gem install fluent-plugin-elasticsearch \
 && sudo gem install fluent-plugin-secure-forward \
 && sudo gem install fluent-plugin-rewrite-tag-filter \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /home/fluent/.gem/ruby/2.5.0/cache/*.gem

COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/

RUN secure-forward-ca-generate /etc/td-agent/ 'password' \
 && mkdir -p /var/log/td-agent \
 && chown fluent /var/log/td-agent \
 && chmod +x /bin/entrypoint.sh

USER fluent
