FROM synominit/docker-mono-base
MAINTAINER synominit

#Create system user and group for secure by default
ENV USER=radarr
ENV GROUP=media
ENV UID=72327
ENV GID=63342

RUN adduser \
    --disabled-password \
    --gecos "" \
    --no-create-home \
    --uid "$UID" \
    "$USER" \

# Install radarr
&& mkdir -p /app/radarr \
&& mkdir -p /build \
&& radarr_tag=$(curl -sX GET "https://api.github.com/repos/Radarr/Radarr/releases" | awk '/tag_name/{print $4;exit}' FS='[""]') \
&& curl -o /build/radarr.tar.gz -L "https://github.com/galli-leo/Radarr/releases/download/${radarr_tag}/Radarr.develop.${radarr_tag#v}.linux.tar.gz" \
&& tar xzf /build/radarr.tar.gz -C /app/radarr --strip-components=1 \
&& rm -rf /build \
&& chown -R "$USER" /app/radarr



# Add local files
#COPY root /

# Ports and Volumes
VOLUME /config /downloads /tv
EXPOSE 7878

USER radarr

CMD cd /app/radarr \
&& mono Radarr.exe -data=/config
