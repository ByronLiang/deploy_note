# Win10 使用 Docker ToolBox

## 安装

一键安装包: `DockerToolbox-19.03.1.exe` 包含基本软件环境进行安装

### 基本环境

- 依赖 VirtualBox 创建虚拟节点, 使用 `boot2docker.iso` 镜像为内核

- 依赖 Git 软件运行 Docker Terminal (执行 start.sh 脚本) 指定对应 Git 路径

### 核心原理

主要利用 `docker-machine` 在 virtualBox 平台 创建 docker 容器; 核心脚本是 `start.sh`

`docker-machine create -d virtualbox 容器名称` 命令: 在 virtualbox 创建 以 boot2docker.iso 内核 的 容器平台

#### docker-machine 常用命令

若不指定名称, 默认查看 `default` 命名的 docker

`docker-machine ls` 列出容器节点

`docker-machine start/restart/stop 名称` 启动/重启、关闭 docker 容器

`docker-machine env 名称` 查看容器环境变量

`docker-machin ssh 名称` 以 ssh 方式登进容器内部

### 配置注意

1. 配置Docker 存储位置环境变量: `MACHINE_STORAGE_PATH` 否则默认会在`C:\\Users\用户名\\.docker\`路径建立虚拟容器

2. 快捷程序应用 `Docker Quickstart Terminal` 无法启动: 点击右键-查看属性, 对 `目标` 配置进行排查, Git 程序路径是否正确, `start.sh`脚本路径是否正确

3. 动态配置 Docker 内存 与 硬盘大小: 默认 `start.sh` 脚本创建虚拟节点 为 1GB 内存 与 20GB 硬盘；

`docker-machine -D create -d virtualbox --virtualbox-memory 1024 --virtualbox-disk-size "8000" default` 调整脚本, 配置内存 为 1GB, 硬盘大小为8GB

4. 环境变量 `Docker Host` 为宿主机IP地址; 容器宿主IP 与 Windows 宿主IP 地址能相互 ping 通
