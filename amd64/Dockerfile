FROM node:10.4.1-stretch

WORKDIR /builder

COPY . /builder
RUN npm install && npm run-script prepare

RUN amd64/build_node.sh

RUN apt-get update &&\
    apt-get install -y\
    libffi-dev \
    ruby \
    ruby-dev \
    rubygems &&\
    gem install --no-ri --no-rdoc rake && \
    gem install --no-ri --no-rdoc fpm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
