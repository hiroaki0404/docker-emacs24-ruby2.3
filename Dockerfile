FROM ruby:2.3

MAINTAINER hiroaki0404@gmail.com

# build
#  docker build -t emacs-ruby .
# run(ex. Mac/docker-machine)
#  docker `docker-machine config xxx` run -d -P -v /Users:/Users -v $HOME/Dropbox/dot.docker/.emacs.d:/home/docker/.emacs.d/ emacs-ruby
# run(ex. Windows(MINGW)/docker-machine)
#  docker `docker-machine config xxx` run -d -P -v //c/Users:/Users -v //c/Users/your-name/dot.docker/.emacs.d:/home/docker/.emacs.d/ emacs-ruby

ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'ZONE="Asia/Tokyo"' > /etc/timezone && dpkg-reconfigure tzdata
ENV TZ=JST-9

RUN apt-get update -y && \
    apt-get install -y locales sudo openssh-server xterm xauth emacs24-nox emacs24-el emacs-mozc screen && \
    locale-gen en_US.UTF.8
RUN mkdir -p /var/run/sshd
RUN useradd docker \
        && passwd -d docker \
        && mkdir /home/docker \
        && chown docker:docker /home/docker \
        && addgroup docker staff \
        && addgroup docker sudo \
	&& chsh -s /bin/bash docker \
        && true
RUN echo "docker:docker" | /usr/sbin/chpasswd

EXPOSE 22

CMD /usr/sbin/sshd -D
