FROM nvidia/cuda:10.1-devel
ENV LANG C.UTF-8
ENV FFMPEG_VERSION 3.4.2

WORKDIR /srv

RUN apt-get update && apt-get install -y git build-essential yasm cmake libtool libc6 libc6-dev unzip wget \
  libnuma1 libnuma-dev frei0r-plugins-dev libgnutls28-dev libass-dev libmp3lame-dev libopencore-amrnb-dev \
  libopencore-amrwb-dev libopus-dev librtmp-dev libsoxr-dev libspeex-dev libtheora-dev \
  libvo-amrwbenc-dev libvorbis-dev libvpx-dev libwebp-dev libx264-dev libx265-dev libxvidcore-dev

RUN wget http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz -O ffmpeg.tar.gz && tar -xvf ffmpeg.tar.gz

RUN cd ffmpeg-${FFMPEG_VERSION} && \
    ./configure --enable-nonfree \
                --disable-shared \
                --enable-nvenc \
                --enable-cuda \
                --enable-cuvid \
                --enable-libnpp \
                --extra-cflags=-Ilocal/include \
                --enable-gpl \
                --enable-version3 \
                --disable-debug \
                --disable-ffplay \
                --disable-indev=sndio \
                --disable-outdev=sndio \
                --enable-fontconfig \
                --enable-frei0r \
                --enable-gnutls \
                --enable-gray \
                --enable-libass \
                --enable-libfreetype \
                --enable-libfribidi \
                --enable-libmp3lame \
                --enable-libopencore-amrnb \
                --enable-libopencore-amrwb \
                --enable-libopus \
                --enable-librtmp \
                --enable-libsoxr \
                --enable-libspeex \
                --enable-libtheora \
                --enable-libvo-amrwbenc \
                --enable-libvorbis \
                --enable-libvpx \
                --enable-libwebp \
                --enable-libx264 \
                --enable-libx265 \
                --enable-libxvid \
                --extra-cflags=-I/usr/local/cuda/include \
                --extra-ldflags=-L/usr/local/cuda/lib64 && \
    make -j 8 && \
    make install  && \
    make clean

