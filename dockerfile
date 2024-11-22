FROM ruby:3.2.2-alpine3.16

RUN apk add build-base tzdata

RUN wget -O - https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2 | tar -xj && \
  cd jemalloc-5.2.1 && \
  ./configure && \
  make && \
  make install

ARG BUNDLE_GITHUB_TOKEN

ENV LD_PRELOAD=/usr/local/lib/libjemalloc.so.2

ENV APP_HOME=/app

RUN mkdir ${APP_HOME}
WORKDIR ${APP_HOME}

COPY . ${APP_HOME}/

ENV BUNDLE_GITHUB__COM=$BUNDLE_GITHUB_TOKEN

RUN apk add --no-cache openssh

# Copy the Gemfile
COPY Gemfile ${APP_HOME}/Gemfile
COPY Gemfile.lock ${APP_HOME}/Gemfile.lock

# Make sure we are running bundler version 2.0
RUN gem install bundler
RUN bundle install

# Copy the project over
COPY . ${APP_HOME}

# ENTRYPOINT ["sh", "./entrypoint.sh"]

EXPOSE 3000
