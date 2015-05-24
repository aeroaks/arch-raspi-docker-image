FROM scratch

MAINTAINER Masami Ichikawa <masami256@gmail.com>

ADD bootstrap.tar.xz /

RUN pacman --noconfirm -Syu

CMD ["/usr/bin/bash"]

