FROM armhf/alpine:edge
MAINTAINER florid

EXPOSE 9001 9050

RUN build_pkgs=" \
        openssl-dev \
        zlib-dev \
        libevent-dev \
        gnupg \
        " \
  && runtime_pkgs=" \
        build-base \
        openssl \
        zlib \
        libevent \
        " \
  && apk --update add ${build_pkgs} ${runtime_pkgs}

RUN cd /tmp \
  && wget https://www.torproject.org/dist/tor-0.3.3.6.tar.gz \
  && tar xzvf tor-0.3.3.6.tar.gz \
  && cd /tmp/tor-0.3.3.6 \
  && ./configure \
  && make -j6 \
  && make install \
  && cd \
  && rm -rf /tmp/* \
  && apk del ${build_pkgs} \
  && rm -rf /var/cache/apk/*

RUN adduser -Ds /bin/sh tor

RUN mkdir /etc/tor
COPY torrc /etc/tor/

RUN mkdir /home/tor/.tor && chown tor:tor /home/tor/.tor -R

USER tor
CMD ["tor", "-f", "/etc/tor/torrc"]
