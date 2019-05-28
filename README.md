## Description

A docker image to run ffmpeg with nvidia gpu hardware acceleration. Updated to CUDA 10.1.

This is a forked version. See also the original repos like https://github.com/larry011/docker-ffmpeg-nvidia

## How to build

```
$ git clone https://github.com/dmiyakawa/docker-ffmpeg-nvidia.git
$ cd docker-ffmpeg-nvidia
$ docker build . -t ffmpeg-nvidia:latest
```

## Run

For a sample video, consider using BBB: https://peach.blender.org/download/

```
$ sudo docker run \
  --runtime=nvidia \
  -e NVIDIA_DRIVER_CAPABILITIES=compute,utility,video \
  -v $(pwd):/srv/videos \
  --rm \
  ffmpeg-nvidia:latest \
  ffmpeg -y -vsync 0 -hwaccel cuvid -i "/srv/videos/input.mp4" \
    -filter:v hwupload_cuda,scale_npp=w=576:h=480:format=yuv420p:interp_algo=lanczos,hwdownload,format=yuv420p \
    -c:a copy -c:v h264_nvenc -b:v 5M \
    /srv/videos/output.mp4
```
