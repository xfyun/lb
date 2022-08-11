FROM golang as builder
MAINTAINER ybyang7@iflytek.com

ENV GOPROXY=https://goproxy.cn,direct
WORKDIR /build
RUN pwd
RUN ls -lh
COPY * /build/
RUN pwd
RUN ls -lh
RUN mkdir -p output/include &&  go build -v -o ./output/lb -gcflags "-N -l -c 10"


#FROM  artifacts.iflytek.com/docker-private/jianjiang/ubuntu_go:20.04_1.16 as prod
FROM golang
MAINTAINER ybyang7
WORKDIR /home/aiges
COPY --from=builder /home/aiges/output .


#ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/aiges:/home/wrapper/wrappere_lib
