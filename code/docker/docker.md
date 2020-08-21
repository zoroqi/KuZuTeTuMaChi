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

* 挂载磁盘

```
docker run -v local_path:image_path xxxx
```

## 基础操作

* 删除本地镜像

```
docker rmi IMAGE_ID
```

1. 提示无法删除, 可能需要先删除对应`containers`

* 删除运行过的容器信息
```
docker rmi containers_id
```

* 获得当前运行中的容器

```
docker ps
```

* 显示所有容器, 包括未运行的
```
docker ps -a
```
