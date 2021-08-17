FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -yq curl apt-transport-https ca-certificates
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN  apt-get install -y nodejs
RUN  npm install -g npm
RUN npm install -g grunt-cli


RUN DEBIAN_FRONTEND="noninteractive" apt-get install --force-yes -yq wget build-essential libcurl4-gnutls-dev libglib2.0-dev \
libgdk-pixbuf2.0-dev \
libgtkglext1-dev \
libatk1.0-dev \
libcairo2-dev \
libxml2-dev \
libxss-dev \
libgconf2-dev \
default-jre \
qt5-qmake \
qt5-default \
p7zip-full \
git \
subversion


RUN git clone --recursive https://github.com/ONLYOFFICE/DocumentServer.git

RUN ls
RUN cd DocumentServer && sed -i 's/exports.LICENSE_CONNECTIONS = 20;/exports.LICENSE_CONNECTIONS = 99999;/' server/Common/sources/constants.js
RUN cd DocumentServer/core/Common/3dParty && ./make.sh
#RUN cd DocumentServer/core && ls
#RUN cd DocumentServer/core/Common/3dParty/hunspell && make
RUN cd DocumentServer/sdkjs && make
RUN cd DocumentServer/server && make

RUN apt-get install -y adduser redis-server rabbitmq-server nodejs libstdc++6 libcurl3 libxml2 libboost-regex-dev zlib1g fonts-dejavu fonts-liberation ttf-mscorefonts-installer fonts-crosextra-carlito fonts-takao-gothic fonts-opensymbol libxss1 libcairo2 xvfb libxtst6 libgconf2-4 libasound2

RUN for font in \
lohit-assamese \
lohit-bengali \
lohit-devanagari \
lohit-gujarati \
lohit-kannada \
lohit-malayalam \
lohit-oriya \
lohit-punjabi \
lohit-tamil \
lohit-tamil-classical \
lohit-telugu \
nanum \
noto \
opensans \
padauk \
samyak \
samyak-fonts \
tibetan-machine \
ttf-khmeros-core \
ubuntu-font-family \
wqy-zenhei; \
do rm -rf build/core-fonts/${font}; done

RUN cd ../server && sudo make install






