# Use a stable base image
FROM almalinux:8

# Set metadata
LABEL maintainer="your_email@example.com"

# Install necessary packages and add a repository for compatibility if needed
RUN yum clean all && \
    yum -y install yum-utils && \
    yum-config-manager --add-repo http://vault.centos.org/centos/8/AppStream/x86_64/os/ && \
    yum install -y httpd zip unzip && \
    yum clean all

# Copy and configure application files
COPY elearning.zip /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Unzip and organize the files
RUN unzip elearning.zip && \
    cp -rvf elearning-html-template/* . && \
    rm -rf elearning-html-template elearning.zip* elearning.zip.? elearning.zip

# Start the Apache HTTP server
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]

# Expose the necessary ports
EXPOSE 80 22
