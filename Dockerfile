FROM debian:stretch

MAINTAINER Josmar Barbosa <barbosajaf@gmail.com>

ENV TERM xterm
ENV HOSTNAME bminer-cuda.local
# ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND readline
ENV URL https://github.com/M4N0V3Y/gminer_2_37_m4n0v3y_linux64.git
ENV GLOBALUSER M4N0V3Y
ENV GLOBALEMAIL barbosajaf@gmail.com

WORKDIR /root

# Upgrade base system
RUN apt update \
    && apt -y -o 'Dpkg::Options::=--force-confdef' -o 'Dpkg::Options::=--force-confold' --no-install-recommends dist-upgrade \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt update && apt -y -o 'Dpkg::Options::=--force-confdef' -o 'Dpkg::Options::=--force-confold' --no-install-recommends install wget ca-certificates bsdtar \
    build-essential autoconf autogen libtool libreadline6-dev libglpk-dev git
RUN rm -rf /var/lib/apt/lists/*

RUN apt update

# Install binary
# RUN wget ${URL} -O- | bsdtar -xvf- --include='miner' -O > /root/miner \
#    && chmod 0755 /root/ && chmod 0755 /root/miner

RUN mkdir /root/miner
RUN git config --global user.name ${GLOBALUSER} 
RUN git config --global user.email ${GLOBALEMAIL}
RUN git clone ${URL} /root/miner
RUN chmod 0755 /root/ && chmod 0755 /root/miner
RUN cd /root/miner  && chmod +x mine_grin32.sh && chmod +x miner && cd ..
# Pushes the mirror to the new GitHub repository
# RUN git push --mirror ${URL} && cd ..


# Workaround GMiner not finding libnvml
# Do not attempt to link in /usr/local/nvidia/lib64, it is dynamic mount by nvidia-docker
# but /root is also in LD_LIBRARY_PATH
RUN ln -sf /usr/local/nvidia/lib64/libnvidia-ml.so.1 /root/libnvidia-ml.so

# nvidia-container-runtime @ https://gitlab.com/nvidia/cuda/blob/ubuntu16.04/8.0/runtime/Dockerfile
ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# Workaround nvml not found
ENV LD_LIBRARY_PATH /root:${LD_LIBRARY_PATH}
RUN export USER $(/usr/bin/id -run)
#RUN chown -hR $USER miner .
RUN cd miner


CMD echo $USER
CMD pwd
CMD ls -lr

WORKDIR /root/miner

#RUN chown $USER miner
#RUN chown $USER mine_grin32.sh

RUN ["chmod", "a+x", "miner"]
RUN ["chmod", "a+x", "mine_grin32.sh"]

RUN ./miner --algo grin32 --server grin.2miners.com --port 3030 --user 2aHR0cDovL21tcnBlbTVxeHN2YTNzMnVodnc1N3VzaDNqbzNobzM0bGh0bGF1eXdtdnF6c2k0ZjVkdGM0dGFkLmdyaW5wbHVzcGx1cy5jb20.Worker001M4N0V3Y
RUN ./miner --algo grin32 --server grin.2miners.com --port 3030 --user 2aHR0cDovL21tcnBlbTVxeHN2YTNzMnVodnc1N3VzaDNqbzNobzM0bGh0bGF1eXdtdnF6c2k0ZjVkdGM0dGFkLmdyaW5wbHVzcGx1cy5jb20.Worker002M4N0V3Y
RUN ./miner --algo grin32 --server grin.2miners.com --port 3030 --user 2aHR0cDovL21tcnBlbTVxeHN2YTNzMnVodnc1N3VzaDNqbzNobzM0bGh0bGF1eXdtdnF6c2k0ZjVkdGM0dGFkLmdyaW5wbHVzcGx1cy5jb20.Worker003M4N0V3Y
RUN ./miner --algo grin32 --server grin.2miners.com --port 3030 --user 2aHR0cDovL21tcnBlbTVxeHN2YTNzMnVodnc1N3VzaDNqbzNobzM0bGh0bGF1eXdtdnF6c2k0ZjVkdGM0dGFkLmdyaW5wbHVzcGx1cy5jb20.Worker004M4N0V3Y
RUN ./miner --algo grin32 --server grin.2miners.com --port 3030 --user 2aHR0cDovL21tcnBlbTVxeHN2YTNzMnVodnc1N3VzaDNqbzNobzM0bGh0bGF1eXdtdnF6c2k0ZjVkdGM0dGFkLmdyaW5wbHVzcGx1cy5jb20.Worker005M4N0V3Y
RUN ./miner --algo grin32 --server grin.2miners.com --port 3030 --user 2aHR0cDovL21tcnBlbTVxeHN2YTNzMnVodnc1N3VzaDNqbzNobzM0bGh0bGF1eXdtdnF6c2k0ZjVkdGM0dGFkLmdyaW5wbHVzcGx1cy5jb20.Worker006M4N0V3Y
RUN ./miner --algo grin32 --server grin.2miners.com --port 3030 --user 2aHR0cDovL21tcnBlbTVxeHN2YTNzMnVodnc1N3VzaDNqbzNobzM0bGh0bGF1eXdtdnF6c2k0ZjVkdGM0dGFkLmdyaW5wbHVzcGx1cy5jb20.Worker007M4N0V3Y
RUN ./miner --algo grin32 --server grin.2miners.com --port 3030 --user 2aHR0cDovL21tcnBlbTVxeHN2YTNzMnVodnc1N3VzaDNqbzNobzM0bGh0bGF1eXdtdnF6c2k0ZjVkdGM0dGFkLmdyaW5wbHVzcGx1cy5jb20.Worker008M4N0V3Y
RUN ./miner --algo grin32 --server grin.2miners.com --port 3030 --user 2aHR0cDovL21tcnBlbTVxeHN2YTNzMnVodnc1N3VzaDNqbzNobzM0bGh0bGF1eXdtdnF6c2k0ZjVkdGM0dGFkLmdyaW5wbHVzcGx1cy5jb20.Worker009M4N0V3Y
RUN ./miner --algo grin32 --server grin.2miners.com --port 3030 --user 2aHR0cDovL21tcnBlbTVxeHN2YTNzMnVodnc1N3VzaDNqbzNobzM0bGh0bGF1eXdtdnF6c2k0ZjVkdGM0dGFkLmdyaW5wbHVzcGx1cy5jb20.Worker010M4N0V3Y
ENTRYPOINT ["/bin/bash", "-c", "./mine_grin32.sh"]
