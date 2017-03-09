# pull base image.
FROM java:8

# maintainer details
MAINTAINER Bizruntime

# update packages and install maven
RUN export DEBIAN_FRONTEND=noninteractive && sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update &&  apt-get -y upgrade && apt-get install -y nano wget curl git maven

# attach volumes
VOLUME /volume/git


# create working directory
RUN mkdir -p /local/git

#Copy the COde from git to DOcker
RUN git clone https://github.com/dm-sanath/ServiceChannelWebService2.git /local/git/ServiceChannelWebService2
WORKDIR /local/git/ServiceChannelWebService2

RUN mvn clean install -DskipTests
#RUN  mvn eclipse:clean
#RUN  mvn eclipse:eclipse
#RUN mvn camel:run

EXPOSE 8431 8080
# run terminal
ENTRYPOINT mvn hawtio:camel
