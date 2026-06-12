FROM ubuntu:22.04 AS builder
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    fortune-mod cowsay netcat-openbsd bash \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    fortune-mod cowsay netcat-openbsd bash \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && groupadd -r wisecow && useradd -r -g wisecow wisecow

ENV PATH=$PATH:/usr/games
WORKDIR /app
COPY --chown=wisecow:wisecow wisecow.sh .
RUN chmod +x wisecow.sh
USER wisecow
EXPOSE 4499
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD bash -c 'echo > /dev/tcp/localhost/4499' || exit 1
CMD ["./wisecow.sh"]
