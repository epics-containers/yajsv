# Dockerfile for yet another json schema validator
# The container provides some supply chain protection by building from source
# agains a commit hash

FROM golang:1.21.4 as build

# get version yajsv 1.41 by commit hash
RUN git clone https://github.com/neilpa/yajsv.git && \
    cd yajsv && \
    git checkout 9889895863c595d38aa5d6347dfadb99f2687a51^{commit}

RUN cd /go/yajsv && go build -o /yajsv

FROM alpine:3.18.4 as runtime

COPY --from=build  /yajsv /yajsv

ENTRYPOINT ["/yajsv"]
