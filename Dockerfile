FROM debian:jessie
MAINTAINER supermomonga

## Install dependencies
RUN apt-get update \
    && apt-get install -y\
    autoconf\
    automake\
    libtool\
    texinfo\
    build-essential\
    xorg-dev\
    libgtk2.0-dev\
    libjpeg-dev\
    libncurses5-dev\
    libdbus-1-dev\
    libgif-dev\
    libtiff-dev\
    libm17n-dev\
    libpng12-dev\
    librsvg2-dev\
    libotf-dev\
    libxml2-dev\
    \
    git\
    && rm -rf /var/lib/apt/lists/*

## Install emacs
RUN git clone --depth 1 git://git.sv.gnu.org/emacs.git\
    && cd emacs\
    && ./autogen.sh\
    && ./configure --with-x-toolkit=lucid\
    && make bootstrap\
    && make install

ENV PORT 8000
EXPOSE 8000

VOLUME /root/app
VOLUME /root/.emacs.d

## Run Emacs as a daemon and kepp container alive by usin tail
CMD emacs --daemon --load=/root/app/app.el