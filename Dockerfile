FROM ruby:2.6.0-alpine
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache \
    bash build-base
RUN mkdir /discrepancies_service
WORKDIR /discrepancies_service

COPY Gemfile* /discrepancies_service/

RUN bundle install

COPY . /discrepancies_service
