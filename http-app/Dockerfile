FROM alpine:3.14

WORKDIR app
EXPOSE 8000
RUN apk --no-cache add ruby \
  && adduser -DS httpapp
COPY http_server.rb .
USER httpapp
CMD ["ruby", "http_server.rb"]
