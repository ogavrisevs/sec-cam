FROM centos:7

RUN yum -y install epel-release

RUN rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro

RUN rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm

RUN yum -y update && yum -y install s3cmd ffmpeg

COPY run.sh /run.sh

RUN  chmod 760 /run.sh

ENV TZ=Europe/Riga

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /

CMD  ./run.sh
