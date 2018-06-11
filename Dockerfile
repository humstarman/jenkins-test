FROM lowyard/busybox-curl:latest as build
ENV file_server http://10.254.0.21
RUN mkdir -p /opt && \
    cd /opt && \
    curl -o jenkins.war ${file_server}/jenkins.war

FROM openjdk:8u171-jdk-slim-stretch 
# uncompress & rename svc
RUN mkdir -p /opt
WORKDIR /opt
COPY --from=build /opt/jenkins.war /opt/
RUN apt-get update && \
    apt-get install -y git
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
rm -rf /tmp/* /usr/share/man /usr/share/doc
