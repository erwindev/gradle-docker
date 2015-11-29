#
# Oracle Java 8 + Gradle Dockerfile
#
# Based on:
#    https://github.com/dockerfile/java
#    https://github.com/dockerfile/java/tree/master/oracle-java8
#

# Pull base image.
FROM ubuntu:14.04
MAINTAINER erwin@schoolzilla.com

RUN apt-get update && apt-get install -y software-properties-common unzip

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Gradle
WORKDIR /usr/bin
RUN wget https://downloads.gradle.org/distributions/gradle-2.6-all.zip && \
    unzip gradle-2.6-all.zip && \
    ln -s gradle-2.6 gradle && \
    rm gradle-2.6-all.zip

# Set Appropriate Environmental Variables
ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin
