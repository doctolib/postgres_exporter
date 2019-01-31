FROM golang

WORKDIR /go/src/github.com/wrouesnel/postgres_exporter

COPY . .

RUN go get github.com/sirupsen/logrus && go run mage.go binary

FROM debian:stable-slim

RUN apt-get update && apt-get dist-upgrade -y && apt-get install curl -y && apt-get clean all
RUN useradd -ms /bin/bash monitoring

COPY --from=0 /go/src/github.com/wrouesnel/postgres_exporter/postgres_exporter /usr/bin

EXPOSE 9187

USER monitoring

CMD [ "/usr/bin/postgres_exporter" ]
