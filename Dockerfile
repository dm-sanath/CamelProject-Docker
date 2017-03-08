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
RUN git clone https://github.com/pramod08/CamelProject.git /local/git/CamelProject
WORKDIR /local/git/CamelProject

RUN mvn clean install -DskipTests
RUN  mvn eclipse:clean
RUN  mvn eclipse:eclipse
RUN mvn camel:run

expose 8431
# run terminal
CMD ["/bin/bash"]
