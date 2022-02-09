FROM debian:stable-slim

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y ca-certificates curl && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives

RUN curl -LO https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl && mv kubectl /usr/bin/kubectl

RUN chmod +x /usr/bin/kubectl

RUN curl -LO https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz && \
    tar -xvf gotty_2.0.0-alpha.3_linux_amd64.tar.gz && \
    rm gotty_2.0.0-alpha.3_linux_amd64.tar.gz

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser
USER appuser

EXPOSE 8080

ENTRYPOINT [ "/gotty" ]
CMD [ "-a", "0.0.0.0", "-p", "8080", "--title-format", "KubeTTY","-w", "/bin/bash" ]
