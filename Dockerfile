FROM ruby:2.5.1
MAINTAINER aromeronavia@gmail.com

ARG PROJECT_DIR=/app
WORKDIR ${PROJECT_DIR}

ADD . .

RUN gem update --system
RUN gem install bundler
RUN bundle install --system

CMD ./runserver.sh
