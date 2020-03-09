FROM centos7


# Install Mono Repo
RUN yum -y update; yum  clean all; \
rpmkeys --import "http://pool.sks-keyservers.net/pks/lookup?op=get&search=0x3fa7e0328081bff6a14da29aa6a19b38d3d831ef"; \
su -c 'curl https://download.mono-project.com/repo/centos7-stable.repo | tee /etc/yum.repos.d/mono-centos7-stable.repo'; \

# Install dependencies for Radarr
RUN yum -y install curl gcc gettext git libmediainfo libzen mediainfo mono-core mono-devel \
       mono-locale-extras p7zip par2cmdline python-configobj python-dbus python-devel \
       python-feedparser python-pip sqlite tar unzip wget


# Create the directories for Radarr


# Install Sonarr

# Copy over the daemon to start Sonarr
