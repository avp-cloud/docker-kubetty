FROM debian:stable-slim

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y ca-certificates curl wget socat openssh-client iputils-ping vim nano && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives

# gotty
RUN curl -LO https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz && \
    tar -xvf gotty_2.0.0-alpha.3_linux_amd64.tar.gz && \
    rm gotty_2.0.0-alpha.3_linux_amd64.tar.gz

# kubectl
RUN curl -LO https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl && \
    mv kubectl /usr/bin/kubectl && chmod +x /usr/bin/kubectl

# kubens
RUN curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens && \
    mv kubens /usr/bin/kubens && chmod +x /usr/bin/kubens

# kubectx
RUN curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens && \
    mv kubens /usr/bin/kubectx && chmod +x /usr/bin/kubectx

# helm
RUN curl -LO https://get.helm.sh/helm-v3.8.0-linux-amd64.tar.gz && \
    tar -xvf helm-v3.8.0-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf helm-v3.8.0-linux-amd64.tar.gz linux-amd64

# k9s
RUN curl -LO https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_x86_64.tar.gz && \
    tar -xvf k9s_Linux_x86_64.tar.gz && \
    rm k9s_Linux_x86_64.tar.gz && \
    mv /k9s /usr/bin && \
    chmod +x /usr/bin/k9s

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser
RUN mkdir -p /home/appuser && chown -R appuser:appuser /home/appuser

COPY bashrc /etc/bashrc-addon
RUN cat /etc/bashrc-addon >> /etc/bash.bashrc
COPY entrypoint.sh /entrypoint.sh

USER appuser
WORKDIR /home/appuser

ENV SHELL /bin/bash
ENV TERM xterm-256color
EXPOSE 8080

ENTRYPOINT [ "/entrypoint.sh" ]
