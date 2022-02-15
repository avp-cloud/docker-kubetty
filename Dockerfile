FROM debian:stable-slim

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y ca-certificates curl openssh-client iputils-ping kubectx && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives

RUN curl -LO https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl && mv kubectl /usr/bin/kubectl

RUN chmod +x /usr/bin/kubectl

RUN curl -LO https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz && \
    tar -xvf gotty_2.0.0-alpha.3_linux_amd64.tar.gz && \
    rm gotty_2.0.0-alpha.3_linux_amd64.tar.gz

RUN curl -LO https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_x86_64.tar.gz && \
    tar -xvf k9s_Linux_x86_64.tar.gz && \
    rm k9s_Linux_x86_64.tar.gz && \
    mv /k9s /usr/bin && \
    chmod +x /usr/bin/k9s

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser
RUN mkdir -p /home/appuser && chown -R appuser:appuser /home/appuser

USER appuser
WORKDIR /home/appuser
COPY bashrc /home/appuser/.bashrc
COPY bash_aliases /home/appuser/.bash_aliases

ENV SHELL /bin/bash
ENV TERM xterm-256color
EXPOSE 8080

ENTRYPOINT [ "/gotty" ]
CMD [ "-a", "0.0.0.0", "-p", "8080", "--reconnect", "--permit-arguments", "--title-format", "KubeTTY","-w", "/bin/bash" ]
