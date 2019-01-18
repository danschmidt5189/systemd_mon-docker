FROM ruby:2.5.3-alpine3.8

RUN apk --update upgrade && \
    apk add ca-certificates && \
    rm -rf /var/cache/apk/*

RUN gem install --no-document \
      hipchat \
      mail \
      slack-notifier \
      systemd_mon

ENTRYPOINT ["/usr/local/bundle/bin/systemd_mon"]

CMD ["/systemd_mon.yml"]
