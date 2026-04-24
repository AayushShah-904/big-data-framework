FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

# Fix for "Exit Code 100" - Redirecting to archived Debian repositories
RUN sed -i 's/httpredir.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list

# Now run the installation
RUN apt-get update && apt-get install -y --force-yes wget && \
    wget https://archive.apache.org/dist/pig/pig-0.17.0/pig-0.17.0.tar.gz && \
    tar -xzvf pig-0.17.0.tar.gz && \
    mv pig-0.17.0 /opt/pig && \
    ln -s /opt/pig/bin/pig /usr/bin/pig && \
    rm pig-0.17.0.tar.gz

ENV PIG_HOME=/opt/pig
ENV PIG_CONF_DIR=$PIG_HOME/conf
ENV PIG_CLASSPATH=$PIG_HOME/conf
ENV PATH=$PIG_HOME/bin:$PATH
ENV PIG_HADOOP_VERSION=3

WORKDIR /data
ENTRYPOINT ["/entrypoint.sh"]
CMD ["tail", "-f", "/dev/null"]