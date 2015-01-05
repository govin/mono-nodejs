FROM debian

MAINTAINER Govind Rajagopalan <govind@outlook.com>

# Install Mono
RUN apt-get update \
        && apt-get install wget  -y --no-install-recommends \
        && echo "deb http://download.mono-project.com/repo/debian wheezy/snapshots/3.10.0 main" > /etc/apt/sources.list.d/mono-xamarin.list \
        && wget -qO - http://download.mono-project.com/repo/xamarin.gpg | apt-key add - \
        && apt-get update \
        && apt-get install mono-runtime -y --no-install-recommends \
        && apt-get purge wget -y \
        && apt-get autoremove -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /var/tmp/* \

# Install Nuget
RUN apt-get update && apt-get install -y mono-devel nuget monodevelop-nunit && apt-get clean
RUN mozroots --import --ask-remove

# Install Node.js
RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  npm install -g npm && \
  echo -e '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc


# Install grunt-js
RUN npm install -g grunt-cli


