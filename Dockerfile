FROM centos:7

COPY RPM-GPG-KEY-remi /etc/pki/rpm-gpg/
COPY *.repo /etc/yum.repos.d/

RUN yum update -y && \
    yum install -y epel-release centos-release-scl && \
    yum install -y nginx \
        php56-php-cli \
        php56-php-process \
        php-ZendFramework2-Loader && \
    yum clean all
