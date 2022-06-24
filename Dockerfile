FROM ruby:2.7.6

ENV LANG C.UTF-8
ENV APP_HOME /testRails

RUN apt-get update -qq && apt-get install -y build-essential nodejs npm python locales && npm install --global yarn
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY ./Gemfile $APP_HOME/Gemfile
COPY ./Gemfile.lock $APP_HOME/Gemfile.lock
COPY ./.ruby-version $APP_HOME/.ruby-version
RUN gem install bundler
RUN bundle install
RUN rails webpacker:install
COPY . $APP_HOME

EXPOSE  3000
