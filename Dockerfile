FROM ruby:3.2-slim

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  postgresql-client \
  curl \
  git \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 2.4.19

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle _2.4.19_ install --jobs 4 --retry 5

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]