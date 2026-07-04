# PHP Docker 开发环境

## 📖 项目简介

本项目提供了一个基于 Docker 的 PHP 开发环境，支持 PHP 7.0、7.1 和 8.0 版本，支持 FPM + Xdebug 和 Swoole + Yasd 两种调试模式。所有容器均支持通过 `.env` 文件配置共享目录，方便本地开发。

## ⚠️ 注意

本环境**仅用于开发环境**，不提供生产模式配置。

## 🎯 核心特性

- **多版本 PHP 支持**：提供 PHP 7.0、7.1 和 8.0 三个版本
- **双调试模式**：每个版本支持 FPM + Xdebug 和 Swoole + Yasd 两种模式
- **服务组隔离**：PHP、公共服务、Elasticsearch 三大服务组独立管理
- **环境变量配置**：所有容器支持通过 `.env` 文件设置共享目录
- **统一网络通信**：所有服务通过 Docker 网络互联
- **数据持久化**：MySQL、Redis 数据持久化存储
- **MySQL 多版本支持**：支持 MySQL 5.7 和 8.x 两个版本
- **一键启停**：使用 Docker Compose 简化操作流程

## 📦 服务组说明

### 1. PHP 服务组 (`services/php`)

| 服务 | 版本 | 模式 | 调试工具 |
|------|------|------|----------|
| php70-fpm | 7.0 | FPM | Xdebug 2.9 |
| php70-fpm | 7.0 | Swoole | Yasd 0.3 |
| php71-fpm | 7.1 | FPM | Xdebug 2.9 |
| php71-fpm | 7.1 | Swoole | Yasd 0.3 |
| php80-fpm | 8.0 | FPM | Xdebug 3.x |
| php80-fpm | 8.0 | Swoole | Yasd |

**内置扩展**：
- PDO MySQL / mysqli
- Redis (phpredis)
- Memcached
- GD / Zip / Curl
- BCMath / MBString
- PCNTL / Sockets
- Composer

### 2. 公共服务组 (`services/common`)

| 服务 | 版本 | 说明 |
|------|------|------|
| Nginx | 1.25.x | 高性能 Web 服务器 |
| MySQL | 5.7 / 8.x | 关系型数据库（可配置） |
| Redis | 5.x | 缓存和消息队列 |

### 3. Elasticsearch 服务组 (`services/elasticsearch`)

| 服务 | 版本 | 说明 |
|------|------|------|
| Elasticvue | latest | Elasticsearch 可视化工具 |
| Kibana | 7.10.2 | ES 可视化管理和查询工具 |

## 🚀 快速开始

### 环境要求

- Docker Engine >= 20.10.0
- Docker Compose >= 2.20.0

### 配置环境变量

复制 `.env.example` 为 `.env` 并根据需要修改配置：

```bash
# .env 文件配置说明

# 共享目录根路径
SHARE_DIR=./share

# PHP 项目目录和运行模式
PHP70_DIR=${SHARE_DIR}/php70
PHP71_DIR=${SHARE_DIR}/php71
PHP80_DIR=${SHARE_DIR}/php80

PHP70_MODE=fpm              # fpm 或 swoole
PHP71_MODE=fpm              # fpm 或 swoole
PHP80_MODE=fpm              # fpm 或 swoole

# MySQL 配置（支持 5.7 或 8.x）
MYSQL_VERSION=5.7           # 5.7 或 8.0
MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=default
MYSQL_USER=dev
MYSQL_PASSWORD=dev
MYSQL_DATA_DIR=${SHARE_DIR}/mysql/data
MYSQL_LOG_DIR=${SHARE_DIR}/mysql/logs

# Redis 配置
REDIS_VERSION=5-alpine
REDIS_PASSWORD=
REDIS_DATA_DIR=${SHARE_DIR}/redis/data

# Nginx 配置
NGINX_HTML_DIR=${SHARE_DIR}/nginx/html
NGINX_LOG_DIR=${SHARE_DIR}/nginx/logs
NGINX_CONF_DIR=${SHARE_DIR}/nginx/conf
```

### 启动服务

```bash
# 启动所有服务
docker-compose up -d

# 指定模式启动（fpm 或 swoole）
PHP70_MODE=swoole PHP71_MODE=fpm PHP80_MODE=fpm docker-compose up -d

# 切换 MySQL 版本
MYSQL_VERSION=8.0 docker-compose up -d --build

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down
```

### 切换运行模式

修改 `.env` 文件中的 `PHP70_MODE`、`PHP71_MODE` 和 `PHP80_MODE` 配置：

- `fpm`：使用 FPM + Xdebug 模式，适合传统 Web 开发
- `swoole`：使用 Swoole + Yasd 模式，适合高性能服务开发

修改后重新构建并启动：

```bash
docker-compose up -d --build
```

### 切换 MySQL 版本

修改 `.env` 文件中的 `MYSQL_VERSION` 配置：

- `5.7`：使用 MySQL 5.7
- `8.0`：使用 MySQL 8.0

### Swoole 模式使用说明

当 PHP_MODE 设置为 `swoole` 时，容器会保持运行但不会自动启动任何服务。你需要通过 `docker exec` 进入容器运行 Swoole 脚本：

```bash
# 进入 PHP 7.0 容器
docker exec -it php70-fpm bash

# 进入 PHP 7.1 容器
docker exec -it php71-fpm bash

# 进入 PHP 8.0 容器
docker exec -it php80-fpm bash

# 在容器内运行 Swoole 脚本
php your_swoole_server.php
```

## 🔧 调试配置

### Xdebug 配置（FPM 模式）

IDE 配置：
- 调试端口：9003
- IDE Key：PHPSTORM
- 远程主机：host.docker.internal

### Yasd 配置（Swoole 模式）

IDE 配置：
- 调试端口：9001
- 调试器类型：Xdebug 协议

## 🌐 虚拟主机配置

Nginx 已配置以下虚拟主机，可通过不同域名访问不同版本的 PHP：

| 域名 | 指向服务 | 说明 |
|------|----------|------|
| localhost | php70-fpm | 默认域名，使用 PHP 7.0 |
| php70.localhost | php70-fpm | PHP 7.0 专用域名 |
| php71.localhost | php71-fpm | PHP 7.1 专用域名 |
| php80.localhost | php80-fpm | PHP 8.0 专用域名 |

需要在本地 hosts 文件中添加域名解析：

```
127.0.0.1 localhost php70.localhost php71.localhost php80.localhost
```

## 📁 项目结构

```
php-docker/
├── .env                    # 环境变量配置
├── .env.example            # 环境变量配置模板
├── docker-compose.yaml     # 主 Docker Compose 配置
├── services/
│   ├── php/                # PHP 服务组
│   │   ├── docker-compose.yaml
│   │   ├── .env.example
│   │   ├── php70/          # PHP 7.0 配置
│   │   │   ├── Dockerfile
│   │   │   ├── php.ini
│   │   │   ├── www.conf
│   │   │   ├── zz-xdebug.ini
│   │   │   ├── zz-yasd.ini
│   │   │   └── entrypoint.sh
│   │   ├── php71/          # PHP 7.1 配置
│   │   │   ├── Dockerfile
│   │   │   ├── php.ini
│   │   │   ├── www.conf
│   │   │   ├── zz-xdebug.ini
│   │   │   ├── zz-yasd.ini
│   │   │   └── entrypoint.sh
│   │   └── php80/          # PHP 8.0 配置
│   │       ├── Dockerfile
│   │       ├── php.ini
│   │       ├── www.conf
│   │       ├── zz-xdebug.ini
│   │       ├── zz-yasd.ini
│   │       └── entrypoint.sh
│   ├── common/             # 公共服务组
│   │   ├── docker-compose.yaml
│   │   ├── .env.example
│   │   └── nginx/
│   │       ├── Dockerfile
│   │       ├── entrypoint.sh
│   │       └── conf.d/
│   │           ├── default.conf
│   │           ├── php70.conf
│   │           ├── php71.conf
│   │           └── php80.conf
│   └── elasticsearch/      # Elasticsearch 服务组
│       ├── docker-compose.yaml
│       └── .env.example
└── share/                  # 共享目录（由 .env 配置）
    ├── php70/              # PHP 7.0 项目目录
    ├── php71/              # PHP 7.1 项目目录
    ├── php80/              # PHP 8.0 项目目录
    ├── mysql/              # MySQL 数据目录
    ├── redis/              # Redis 数据目录
    └── nginx/              # Nginx 配置和日志
```

## 🔗 访问地址

| 服务 | 地址 |
|------|------|
| Nginx (默认) | http://localhost |
| Nginx (PHP 7.0) | http://php70.localhost |
| Nginx (PHP 7.1) | http://php71.localhost |
| Nginx (PHP 8.0) | http://php80.localhost |
| MySQL | localhost:3306 |
| Redis | localhost:6379 |
| Elasticvue | http://localhost:8080 |
| Kibana | http://localhost:5601 |

## 📝 License

MIT