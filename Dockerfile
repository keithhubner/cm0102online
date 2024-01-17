FROM ubuntu:20.04

# Specify a workdir, to better organize your files inside the container.
WORKDIR /cm0102


# Update package lists and install required packages
RUN apt-get update && \
    apt-get install -y wget software-properties-common gnupg2 winbind xvfb gosu

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
    apt-get install -y x11vnc tigervnc-scraping-server


# Cleanup unnecessary files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ENV WINEDEBUG=fixme-all

COPY ./scripts/ /cm0102/scripts/

RUN chmod -R gou+x /cm0102/scripts/

COPY entrypoint.sh /cm0102/entrypoint.sh
RUN chmod gou+x /cm0102/entrypoint.sh

EXPOSE 5900

CMD ["/cm0102/entrypoint.sh"]