FROM centos:7

COPY RPM-GPG-KEY-remi /etc/pki/rpm-gpg/
COPY *.repo /etc/yum.repos.d/

RUN yum update -y && \
    yum install -y epel-release centos-release-scl && \
    yum install -y nginx \
        php72-php-cli \
        php72-php-process && \
    yum clean all
