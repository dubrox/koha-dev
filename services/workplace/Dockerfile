FROM debian:bookworm
LABEL maintainer="dubrox@dubrox.com"

RUN apt update \
    && apt install -y \
        ca-certificates \
        curl \
        git \
        sudo \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc \
    && echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
        | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt update \
    && apt install -y \
        containerd.io \
        docker-buildx-plugin \
        docker-ce \
        docker-ce-cli \
        docker-compose-plugin \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*


ARG USER=koha
ENV PROJECTS_DIR=/workplace

RUN useradd -m -s $(which bash) -G sudo $USER \
    && echo "koha ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && usermod -aG docker $USER

RUN mkdir $PROJECTS_DIR \
    && chown $USER:docker $PROJECTS_DIR

USER $USER
RUN echo "export PROJECTS_DIR=$PROJECTS_DIR" >> ~/.koha_bashrc \
    && echo 'export KTD_HOME=$PROJECTS_DIR/koha-testing-docker' >> ~/.koha_bashrc \
    && echo 'export PATH=$PATH:$KTD_HOME/bin' >> ~/.koha_bashrc \
    && echo 'export LOCAL_USER_ID=$(id -u)' >> ~/.koha_bashrc

WORKDIR $PROJECTS_DIR
RUN git clone --branch main --single-branch https://gitlab.com/koha-community/koha-testing-docker.git koha-testing-docker

WORKDIR $PROJECTS_DIR/koha-testing-docker
RUN cp env/defaults.env .env \
    && sed -i '/^KOHA_IMAGE=/s/=.*/=main-bullseye/' .env

ADD --chown=${USER}:docker --chmod=0770 ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "-l", "-c", "/entrypoint.sh"]