FROM golang

WORKDIR /go/src/github.com/wrouesnel/postgres_exporter

COPY . .

RUN go get github.com/sirupsen/logrus && go run mage.go binary

FROM debian:stable-slim

COPY --from=0 /go/src/github.com/wrouesnel/postgres_exporter/postgres_exporter /usr/bin

EXPOSE 9187

CMD [ "/usr/bin/postgres_exporter" ]
