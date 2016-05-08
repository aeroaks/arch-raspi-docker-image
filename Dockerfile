FROM scratch

MAINTAINER Akshay Verma <akshay.tvastr@yahoo.com>

ADD bootstrap.tar.xz /

RUN pacman --noconfirm -Syu

CMD ["/usr/bin/bash"]

