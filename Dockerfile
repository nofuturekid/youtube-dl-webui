FROM amd64/python:3-alpine3.8

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
