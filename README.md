[![Build Status](https://travis-ci.org/elefthei/WebTorch.svg?branch=master)](https://travis-ci.org/elefthei/WebTorch) [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/elefthei/WebTorch/issues)

![WebTorch logo](/public/logo.png?raw=true "WebTorch Deep Learning server")

WebTorch takes advantage of the versatile LuaJIT compiler to bring together Nginx and Torch, creating an equivalent system to Tensorflow serve, but based on a RESTful API instead of protobuf. Multiple data formats are supported (tensors, images etc.) 

## Building WebTorch container

Building (docker/nvidia-docker):
```
docker build -t webtorch .
```

## Running WebTorch container

Running (docker/nvidia-docker):
```
docker run -p 3000:3000 -it webtorch
```

## Usage:

### GET /v1/train
Will train the XOR neural network with a single random (input1, input2) sample.
```
$ curl http://localhost:3000/v1/train
```

### POST /v1/train
*Body*: 2D serialized Torch tensor (see `benchmarks/script/train.lua` for example)
Will train the XOR neural network with a serialized 2D Torch tensor sample.
```
$ wrk -t12 -c400 -d30s -s benchmarks/scripts/train.lua http://localhost:3000/v1/train
```

### GET /v1/output
Will get the result of the trained XOR network on (0.5, 0.5)
```
$ curl http://localhost:3000/v1/output
```

