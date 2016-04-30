FROM alpine:3.3

RUN mkdir -p /usr/local/etc \
  && { \
    echo 'install: --no-document'; \
    echo 'update: --no-document'; \
  } >> /usr/local/etc/gemrc

ENV RUBY_VERSION 2.2.3

RUN set -ex \
  && apk add --no-cache \
    autoconf \
    bash \
    bison \
    bzip2 \
    bzip2-dev \
    ca-certificates \
    coreutils \
    curl \
    gcc \
    git \
    gdbm-dev \
    glib-dev \
    libc-dev \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    make \
    ncurses-dev \
    openssl-dev \
    procps \
    readline-dev \
    yaml-dev \
    zlib-dev

ENV PATH ~/.rbenv/shims:$PATH

RUN git clone --depth 1 git://github.com/rbenv/rbenv.git ~/.rbenv \
&&  git clone --depth 1 git://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

RUN ~/.rbenv/bin/rbenv install $RUBY_VERSION \
&&  ~/.rbenv/bin/rbenv global $RUBY_VERSION

RUN mv /bin/sh /bin/sh.bk && ln /bin/bash /bin/sh

RUN gem install bundler
