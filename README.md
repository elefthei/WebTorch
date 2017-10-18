![WebTorch logo](/public/logo.png?raw=true "WebTorch Deep Learning server")

Nginx + torch + LuaJIT packaged together

## Building WebTorch container

Building (docker):
```
docker build -t webtorch .
```

Building (docker-compose):
```
docker-compose build
```

## Running WebTorch container

Running (docker):
```
docker run -p 3000:3000 -it webtorch
```

Running (docker-compose):
```
docker-compose up
```

## Usage:

### GET /train
Will train the XOR neural network with a single random (input1, input2) sample.
```
$ curl http://localhost/train
```

### POST /train
*Body*: 2D serialized Torch tensor (see `bench/script/train_post.lua` for example)
Will train the XOR neural network with a serialized 2D Torch tensor sample.
```
$ wrk -t12 -c400 -d30s -s bench/scripts/train_post.lua http://localhost/train
```

### GET /output
Will get the result of the trained XOR network on (0.5, 0.5)
```
$ curl http://localhost/output
```


