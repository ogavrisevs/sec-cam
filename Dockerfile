FROM centos

RUN rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm

RUN yum -y install epel-release

RUN yum -y update && yum -y install vlc awscli

RUN easy_install six

RUN adduser vlc

COPY run.sh /home/vlc/run.sh

RUN  chown vlc:vlc /home/vlc/run.sh

RUN  chmod 760 /home/vlc/run.sh

USER vlc

WORKDIR /home/vcl

CMD cd && ./run.sh