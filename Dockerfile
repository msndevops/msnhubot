from alpine

run apk update &&  apk add git nodejs nodejs-dev make bash vim g++ curl unzip npm && rm -rf /var/lib/apk
run adduser -D -u 13802 -g "Madison Devopsbot" -s /bin/bash msndevopsbot
run mkdir -p /var/lib/hubot && chown -R msndevopsbot:msndevopsbot /var/lib/hubot
USER msndevopsbot
WORKDIR /var/lib/hubot
USER root
VOLUME /var/lib/hubot
ADD Dockerfile /
EXPOSE 8000

#CMD ["make"]
