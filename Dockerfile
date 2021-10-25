FROM python:2.7.18-alpine3.11

# Labels.
LABEL maintainer="pavels.gurskis@gmail.com" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.name="pavelsg/ansible-docker" \
    org.label-schema.description="Ansible inside Docker" \
    org.label-schema.url="https://github.com/pavelsg/ansible-docker" \
    org.label-schema.vcs-url="https://github.com/pavelsg/ansible-docker" \
    org.label-schema.vendor="Pavels Gurskis" \
    org.label-schema.docker.cmd="docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa pavelsg/ansible:2.6.1-alpine"

RUN CARGO_NET_GIT_FETCH_WITH_CLI=1 && \
    apk --no-cache add \
        sudo \
        openssl \
        ca-certificates \
        sshpass \
        openssh-client \
        rsync \
        git && \
    apk --no-cache add --virtual build-dependencies \
        libffi-dev \
        musl-dev \
        gcc \
        cargo \
        openssl-dev \
        libressl-dev \
        build-base && \
    pip install --upgrade pip wheel && \
    pip install --upgrade cryptography cffi && \
    pip install 'ansible==2.6.1' && \
    pip install mitogen jmespath && \
    pip install 'ansible-lint==3.1.1' && \
    pip install --upgrade pywinrm && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache/pip && \
    rm -rf /root/.cargo

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

WORKDIR /ansible

CMD [ "ansible-playbook", "--version" ]
