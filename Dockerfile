FROM ruby:2.7.6-alpine3.15

RUN apk add --update alpine-sdk && \
  apk add bash build-base git libxml2-dev libxslt-dev nodejs postgresql-dev readline-dev tzdata zlib-dev && \
  mkdir /app

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app
