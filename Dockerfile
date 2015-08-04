FROM centos:6

MAINTAINER Manuel VACELET <manuel.vacelet@enalean.com>

RUN yum update -y && \
    yum install -y scl-utils && \
    rpm -i https://www.softwarecollections.org/en/scls/rhscl/nginx16/epel-6-x86_64/download/rhscl-nginx16-epel-6-x86_64.noarch.rpm && \
    yum install -y nginx16 && \
    yum clean all

COPY . /root
COPY nginx/nginx.conf /opt/rh/nginx16/root/etc/nginx/nginx.conf

EXPOSE 443

VOLUME /data

CMD "/root/run.sh"
