FROM ruby:3.0.4

WORKDIR /toy-robot-simulator-ruby

COPY Gemfile* ./

RUN bundle install

ADD . .

CMD ["bundle", "exec", "ruby", "-I", "lib", "bin/toy-robot-simulator"]
