FROM amd64/python:3-alpine3.8

# set version label
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.name="youtube-dl-webui" \
      org.label-schema.description="Another webui for youtube-dl powered by Flask." \
      org.label-schema.url="https://hub.docker.com/r/nofuturekid/youtube-dl-webui" \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vcs-url="https://github.com/nofuturekid/youtube-dl-webui" \
      org.label-schema.vendor="nofuturekid" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"
LABEL maintainer="nofuturekid"

# Install bash, ffmpeg, gosu
#
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
  apk add bash ffmpeg gosu@testing

# Install youtube-dl-webui
ENV YOUTUBE_DL_WEBUI_SOURCE /usr/src/youtube_dl_webui
WORKDIR $YOUTUBE_DL_WEBUI_SOURCE

COPY . $YOUTUBE_DL_WEBUI_SOURCE

RUN  pip install --no-cache-dir -r requirements.txt \
        && cp $YOUTUBE_DL_WEBUI_SOURCE/example_config.json /root/youtube-dl-webui.json \
        && cd .. && rm -rf youtube-dl-webui* \
        && chmod 777 $YOUTUBE_DL_WEBUI_SOURCE -R

COPY docker-entrypoint.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

VOLUME /config /downloads

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["python", "-m", "youtube_dl_webui"]
