# docker

## run命令参数
* `-i` 以交互模式运行容器，通常与 -t 同时使用
* `-t` 为容器重新分配一个伪输入终端，通常与 -i 同时使用
* `-t` 后台运行容器，并返回容器ID

## 常用操作
* 拽去某个镜像 `docker pull xxxx`

* 交互式启动
```
docker run -it  xxxx /bin/bash
```

```
docker run -itd xxxx /bin/bash

docker attach CONTAINER ID
```
