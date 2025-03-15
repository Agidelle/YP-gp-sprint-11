FROM golang:1.24 AS build

WORKDIR /app

COPY go.sum go.mod ./

RUN go mod download

ENV APP_NAME="parcel"

COPY *.go ./

RUN CGO_ENABLED=0 go build -o ./${APP_NAME}

FROM alpine:3.21.3

WORKDIR /app

COPY --from=build /app/parcel /app/

COPY tracker.db ./

CMD ["./parcel"]
