FROM alpine

MAINTAINER Tim Schaller <tschaller@syntheticgenomics.com>

# Install dependencies
RUN apk update && apk upgrade \
  && apk add redis \
  && apk add nodejs \
  && apk add python \
  && apk add curl \
  && curl -ksS https://bootstrap.pypa.io/get-pip.py | python \
  && pip install awscli \
  && npm config set strict-ssl false \
  && npm install -g npm \
  && npm install -g coffee-script \
  && npm install -g yo generator-hubot \
  && apk --purge -v del py-pip \
  && rm -rf /var/cache/apk/*

# Create hubot user
RUN adduser -h /hubot -s /bin/bash -S hubot
USER  hubot
WORKDIR /hubot

# Install hubot
RUN npm config set strict-ssl false
RUN yo hubot --owner="Tim Schaller <tschaller@syntheticgenomics.com>" \
             --name="sgibot" \
             --description="A very small shell script." \
             --defaults
COPY package.json package.json
RUN npm install
ADD hubot/hubot-scripts.json /hubot/
ADD hubot/external-scripts.json /hubot/

RUN sed -i '216s/ is \@mucDomain/ is "conf.btf.hipchat.com"/' \
    /hubot/node_modules/hubot-hipchat/src/connector.coffee

EXPOSE 80

# And go
ENTRYPOINT ["/bin/sh", "-c", "bin/hubot --adapter hipchat"]
