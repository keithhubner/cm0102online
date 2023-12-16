FROM ubuntu:20.04

# Specify a workdir, to better organize your files inside the container. 
WORKDIR /cm0102


# Update package lists and install required packages
RUN apt-get update && \
    apt-get install -y wget software-properties-common gnupg2 winbind xvfb

# Add Wine repository and install Wine

ARG DEBIAN_FRONTEND="noninteractive"
RUN dpkg --add-architecture i386 \
        && apt update 
#        && apt install -y --install-recommends apt-utils \
#        && apt install -y --install-recommends wine-stable wine32 \
#        && useradd -m wine

RUN dpkg --add-architecture i386

RUN mkdir -pm755 /etc/apt/keyrings

RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources

RUN apt update

RUN apt install --install-recommends wine32 winetricks -y

RUN apt-get update && \
    apt-get install -y x11vnc


# Cleanup unnecessary files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ENV WINEDEBUG=fixme-all

ENV WINEPREFIX=/root/.cm0102

COPY data3/ /root/.cm0102

# COPY app /root/catalyst
COPY startup.sh /cm0102/startup.sh
RUN chmod gou+x /cm0102/startup.sh

COPY run.sh /cm0102/run.sh
RUN chmod gou+x /cm0102/run.sh

COPY wine.sh /cm0102/wine.sh
RUN chmod gou+x /cm0102/wine.sh

# COPY CM0102.iso /cm0102/CM0102.iso
# RUN chmod gou+x /cm0102/CM0102.iso

EXPOSE 5900

# CMD ["/root/startup.sh"]
