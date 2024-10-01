FROM centos:latest
# LABEL key="value"
RUN yum install -y httpd \
    zip \
    unzip
COPY elearning.zip /var/www/html
WORKDIR /var/www/html
RUN unzip elearning.zip
RUN cp -rvf elearning-html-template/* .
RUN rm -rf elearning-html-template elearning.zip
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
EXPOSE 80 22