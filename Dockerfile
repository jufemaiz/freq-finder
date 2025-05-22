FROM ruby:3.4.4-alpine

RUN apk add --update alpine-sdk && \
  apk add bash build-base git libxml2-dev libxslt-dev nodejs postgresql-dev readline-dev tzdata yaml-dev zlib-dev && \
  gem install bundler && \
  mkdir /app

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app
