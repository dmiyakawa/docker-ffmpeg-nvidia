FROM nvidia/cuda:8.0-devel

WORKDIR /tmp

COPY sources.list /etc/apt/

RUN apt-get update && apt-get install -y git build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev frei0r-plugins-dev libgnutls28-dev libass-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenjpeg-dev libopus-dev librtmp-dev libsoxr-dev libspeex-dev libtheora-dev libvo-amrwbenc-dev libvorbis-dev libvpx-dev libwebp-dev libx264-dev libx265-dev libxvidcore-dev

RUN wget http://7xqh5p.com1.z0.glb.clouddn.com/FFmpeg-release-3.3.zip && unzip FFmpeg-release-3.3.zip

RUN cd FFmpeg-release-3.3 && \
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
                --enable-libopenjpeg \
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
    make install


RUN wget https://npm.taobao.org/mirrors/node/latest-v9.x/node-v9.7.1-linux-x64.tar.gz && \
    tar -xvf node-v9.7.1-linux-x64.tar.gz && \
    cp -rf node-v9.7.1-linux-x64/* /usr/local/ && \
    npm config set registry https://registry.npm.taobao.org/