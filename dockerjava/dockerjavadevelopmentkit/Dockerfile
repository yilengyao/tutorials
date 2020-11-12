# extending from ubuntu:18.04
FROM ubuntu:18.04

# key value pair
LABEL maintainer="Yi leng Yao contact@yi.com"

# Run is to run the following command on the base image
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk
    
# specifying the location of the working directory in the container
# in which we want to work with
WORKDIR /usr/local/bin

# Copying files to the container
# COPY <source> <destination>
# Copies the jar file to home working directory
COPY test-program.jar .
    
# What command to execute when the container is runned, 
# in this case it is a bash shell
CMD ["java", "-jar", "test-program.jar"]