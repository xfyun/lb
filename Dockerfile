FROM golang as builder
MAINTAINER ybyang7@iflytek.com

ENV GOPROXY=https://goproxy.cn,direct
RUN apt-get update && apt-get install -y libnuma-dev build-essential
WORKDIR /build
RUN ls -lh
COPY * /build/
RUN ls -lh
RUN mkdir -p output/include &&  go build -v -o ./output/lb -gcflags "-N -l -c 10"


#FROM  artifacts.iflytek.com/docker-private/jianjiang/ubuntu_go:20.04_1.16 as prod
FROM golang
MAINTAINER ybyang7
RUN echo '''deb https://mirrors.aliyun.com/debian/ bullseye main non-free contrib \
deb-src https://mirrors.aliyun.com/debian/ bullseye main non-free contrib \
deb https://mirrors.aliyun.com/debian-security/ bullseye-security main \
deb-src https://mirrors.aliyun.com/debian-security/ bullseye-security main \
deb https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib \
deb-src https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib \
deb https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib \
deb-src https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib''' >/etc/apt/sources.list

WORKDIR /home/loader
RUN apt update && apt install -y build-essential vim

ENV TZ Asia/Shanghai

RUN DEBIAN_FRONTEND=noninteractive apt update &&apt install -y libnuma-dev libboost-all-dev
WORKDIR /home/aiges
COPY --from=builder /home/aiges/output .


#ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/aiges:/home/wrapper/wrappere_lib
