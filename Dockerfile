FROM rockylinux:latest

LABEL maintainer="Joerg Klein <kwp.klein@gmail.com>" \
      description="Docker base image for SvxLink (Echolink)"

RUN dnf update -y  \
    && dnf --enablerepo=powertools install -y doxygen gsm-devel groff libsigc++20-devel opus-devel speex-devel qt5-devel.noarch \
    && dnf install -y alsa-utils alsa-lib-devel bzip2 cmake make gcc gcc-c++ libgcrypt-devel libcurl-devel mesa-dri-drivers popt-devel tcl-devel zip \
    && dnf install -y epel-release \
    && dnf install -y jsoncpp-devel \
    && dnf clean all \
    && rm -rf /var/cache/dnf

# Download the source file
ENV VERSION 19.09.2
ENV BINARY ${VERSION}.zip

RUN curl -LJO https://github.com/sm0svx/svxlink/archive/${BINARY} \
    && unzip svxlink-${BINARY} -d /usr/src/ \
#    && tar xzf svxlink-${BINARY} -C /usr/src/ \
    && rm svxlink-${BINARY}

# Download the sound files
RUN mkdir -p /usr/share/svxlink/sounds \
    && cd /usr/share/svxlink/sounds \
    && curl -LJO https://github.com/sm0svx/svxlink-sounds-en_US-heather/releases/download/19.09/svxlink-sounds-en_US-heather-16k-19.09.tar.bz2 \
    && tar xvaf svxlink-sounds-* \
    && ln -sf en_US-heather-16k en_US \
    && rm svxlink-sounds-*

# Create user svxlink
RUN groupadd svxlink
RUN useradd -r -g daemon -G svxlink -c "SvxLink" svxlink

# Set workdir to compile the source code
WORKDIR /usr/src/svxlink-${VERSION}/src

# Build and install svxlink
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc -DLOCAL_STATE_DIR=/var -DCMAKE_BUILD_TYPE=Release .
RUN make && make doc && make install && make clean
RUN ldconfig

# Set workdir to /root
WORKDIR /root

# Copy asoundrc to .asoundrc
COPY asoundrc /root/.asoundrc

# CMD ["./svxlink"]
