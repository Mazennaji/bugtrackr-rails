FROM ruby:3.2-slim

RUN echo "precedence ::ffff:0:0/96  100" >> /etc/gai.conf

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  libyaml-dev \
  libffi-dev \
  postgresql-client \
  curl \
  git \
  ca-certificates \
  openssl \
  && update-ca-certificates \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
COPY vendor/cache ./vendor/cache

RUN gem install bundler -v 2.4.19 && \
    bundle _2.4.19_ config set retry 15 && \
    bundle _2.4.19_ config set jobs 1 && \
    bundle _2.4.19_ config set without 'tools' && \
    bundle _2.4.19_ install --local

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]