FROM centos:6

MAINTAINER Manuel VACELET <manuel.vacelet@enalean.com>

RUN yum update -y && \
    yum install -y scl-utils && \
    rpm -i https://www.softwarecollections.org/en/scls/rhscl/nginx16/epel-6-x86_64/download/rhscl-nginx16-epel-6-x86_64.noarch.rpm && \
    yum install -y nginx16 && \
    yum clean all


RUN mkdir -p /opt/rh/nginx16/root/etc/nginx/ssl && \
    openssl genrsa -out /opt/rh/nginx16/root/etc/nginx/ssl/server.key 1024  && \
    openssl req -new -subj "/C=FR/ST=Denial/L=Springfield/O=Dis/CN=*" -key /opt/rh/nginx16/root/etc/nginx/ssl/server.key -out /opt/rh/nginx16/root/etc/nginx/ssl/server.csr  && \
    openssl x509 -req -days 365 -in /opt/rh/nginx16/root/etc/nginx/ssl/server.csr -signkey /opt/rh/nginx16/root/etc/nginx/ssl/server.key -out /opt/rh/nginx16/root/etc/nginx/ssl/server.crt

RUN yum install -y epel-release && yum install -y install inotify-tools

COPY . /root
COPY nginx/nginx.conf /opt/rh/nginx16/root/etc/nginx/nginx.conf

EXPOSE 443

VOLUME /reverseproxy_data

CMD "/root/run.sh"
