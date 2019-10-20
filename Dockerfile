FROM elixir:latest
LABEL maintainer="Thomas Citharel <tcit@tcit.fr>"

ENV REFRESHED_AT=2019-10-20
RUN apt-get update -yq && apt-get install -yq jpegoptim pngquant gifsicle optipng libjpeg-progs webp
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash && apt-get install nodejs -yq
RUN npm install -g svgo
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mix local.hex --force && mix local.rebar --force
