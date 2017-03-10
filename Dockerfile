FROM centos:7

RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y nginx && \
    yum clean all

CMD [ "/tuleap/tools/distlp/reverse-proxy/run.sh" ]
