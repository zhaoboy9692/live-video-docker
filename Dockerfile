FROM daocloud.io/ubuntu:18.04
MAINTAINER genezhao zhaoboy9692@163.com
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
ENV DEBIAN_FRONTEND noninteractive
RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN  apt-get clean
RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get -y update \
    && apt-get -y install apt-utils \
    && apt-get install -y build-essential unzip pkg-config \
        zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
        libssl-dev libreadline-dev libffi-dev wget ffmpeg librtmp-dev
RUN apt-get install -y curl python3.7 python3.7-dev python3.7-distutils
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
RUN update-alternatives --set python /usr/bin/python3.7
RUN curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.7 get-pip.py --force-reinstall && \
    rm get-pip.py
RUN python3.7 -m pip install python-librtmp==0.3.0 pyppeteer==0.2.2 -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN   pyppeteer-install
