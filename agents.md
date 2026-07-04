# Agents - PHP Docker 开发环境技能文档

## 项目概述

本项目是一个基于 Docker 的 PHP 开发环境，支持多版本 PHP（7.0、7.1、8.0）和多种调试模式（Xdebug、Yasd）。

---

## 项目文件夹结构

```
php-docker/
├── .agents/                    # 技能文档目录
│   └── xdebug-yasd-debug.md    # Xdebug/Yasd 调试配置技能
├── services/                   # 服务组目录
│   ├── php/                    # PHP 服务组
│   │   ├── php70/              # PHP 7.0 配置
│   │   │   ├── Dockerfile      # PHP 7.0 镜像构建文件
│   │   │   ├── entrypoint.sh   # 启动脚本（支持 FPM/Swoole 切换）
│   │   │   ├── php.ini         # PHP 配置文件
│   │   │   ├── www.conf        # PHP-FPM 配置文件
│   │   │   ├── zz-xdebug.ini   # Xdebug 配置模板
│   │   │   └── zz-yasd.ini     # Yasd 配置模板
│   │   ├── php71/              # PHP 7.1 配置
│   │   │   ├── Dockerfile
│   │   │   ├── entrypoint.sh
│   │   │   ├── php.ini
│   │   │   ├── www.conf
│   │   │   ├── zz-xdebug.ini
│   │   │   └── zz-yasd.ini
│   │   └── php80/              # PHP 8.0 配置
│   │       ├── Dockerfile
│   │       ├── entrypoint.sh
│   │       ├── php.ini
│   │       ├── www.conf
│   │       ├── zz-xdebug.ini
│   │       └── zz-yasd.ini
│   ├── common/                 # 公共服务组
│   │   └── nginx/              # Nginx 配置
│   │       ├── conf.d/         # Nginx 虚拟主机配置目录
│   │       │   ├── default.conf    # 默认站点配置
│   │       │   ├── php70.conf      # PHP 7.0 站点配置
│   │       │   ├── php71.conf      # PHP 7.1 站点配置
│   │       │   └── php80.conf      # PHP 8.0 站点配置
│   │       ├── Dockerfile      # Nginx 镜像构建文件
│   │       └── entrypoint.sh   # Nginx 启动脚本
│   └── elasticsearch/          # Elasticsearch 服务组（仅服务定义，无配置文件）
├── .env                        # 环境变量配置（本地）
├── .env.example                # 环境变量配置模板
├── .gitignore                  # Git 忽略规则
├── agents.md                   # 本文件 - 技能说明文档
├── docker-compose.yaml         # 主编排配置（包含所有服务组）
└── README.md                   # 项目说明文档
```

---

## 服务组说明

### 1. PHP 服务组（services/php/）

| 服务名 | PHP 版本 | 基础镜像 | 默认端口 | 支持模式 |
|--------|----------|----------|----------|----------|
| php70-fpm | 7.0 | php:7.0-fpm | 9000 | FPM + Xdebug / Swoole + Yasd |
| php71-fpm | 7.1 | php:7.1-fpm | 9000 | FPM + Xdebug / Swoole + Yasd |
| php80-fpm | 8.0 | php:8.0-fpm | 9000 | FPM + Xdebug / Swoole + Yasd |

**扩展支持：**
- 基础扩展：pdo_mysql、mysqli、gd、zip、curl、opcache、bcmath、mbstring、pcntl、sockets
- 可选扩展：redis、memcached
- 调试扩展：Xdebug（FPM 模式）、Yasd（Swoole 模式）

### 2. 公共服务组（services/common/）

| 服务名 | 默认端口 | 说明 |
|--------|----------|------|
| nginx | 80/443 | 反向代理，支持虚拟主机配置 |
| mysql | 3306 | 数据库服务，支持 5.7/8.0 版本切换 |
| redis | 6379 | 缓存服务，支持密码认证 |

**MySQL 多版本支持：**
- 通过 `.env` 文件配置 `MYSQL_VERSION` 变量
- 支持值：`5.7`（默认）、`8.0`

### 3. Elasticsearch 服务组（services/elasticsearch/）

| 服务名 | 默认端口 | 说明 |
|--------|----------|------|
| elasticvue | 8080 | Elasticsearch 可视化管理工具 |
| kibana | 5601 | Elasticsearch 数据可视化平台 |

---

## 技能列表

### 1. Xdebug/Yasd 调试配置技能

**文件位置：** [.agents/xdebug-yasd-debug.md](file:///d:/code/php-docker/.agents/xdebug-yasd-debug.md)

**能力说明：**

| 能力项 | 描述 |
|--------|------|
| Xdebug 配置 | 提供 VS Code + Xdebug 调试 PHP FPM 模式的完整配置指南 |
| Yasd 配置 | 提供 VS Code + Yasd 调试 PHP Swoole 模式的完整配置指南 |
| 多版本支持 | 支持 PHP 7.0、7.1、8.0 三个版本的调试配置 |
| 断点调试 | 支持设置断点、变量查看、堆栈跟踪等调试功能 |
| launch.json | 提供完整的 `launch.json` 配置示例 |
| 问题排查 | 提供常见问题排查指南和日志查看方法 |

**使用场景：**
- 开发人员需要配置 VS Code 调试环境
- 需要在 FPM 模式下调试传统 PHP Web 应用
- 需要在 Swoole 模式下调试高性能 PHP 服务
- 需要切换不同 PHP 版本进行调试

**配置文件生成：**
该技能可以帮助用户生成以下配置文件：
- `.vscode/launch.json` - VS Code 调试配置文件

---

## 环境变量配置

### 核心配置项

| 变量名 | 默认值 | 说明 |
|--------|--------|------|
| SHARE_DIR | ./share | 共享目录根路径 |
| PHP70_MODE | fpm | PHP 7.0 运行模式（fpm/swoole） |
| PHP71_MODE | fpm | PHP 7.1 运行模式（fpm/swoole） |
| PHP80_MODE | fpm | PHP 8.0 运行模式（fpm/swoole） |
| MYSQL_VERSION | 5.7 | MySQL 版本（5.7/8.0） |
| MYSQL_ROOT_PASSWORD | root | MySQL root 密码 |
| REDIS_PASSWORD | 空 | Redis 密码（为空则不启用认证） |

### 目录配置项

| 变量名 | 默认值 | 说明 |
|--------|--------|------|
| PHP70_DIR | ${SHARE_DIR}/php70 | PHP 7.0 项目目录 |
| PHP71_DIR | ${SHARE_DIR}/php71 | PHP 7.1 项目目录 |
| PHP80_DIR | ${SHARE_DIR}/php80 | PHP 8.0 项目目录 |
| MYSQL_DATA_DIR | ${SHARE_DIR}/mysql/data | MySQL 数据目录 |
| MYSQL_LOG_DIR | ${SHARE_DIR}/mysql/logs | MySQL 日志目录 |
| REDIS_DATA_DIR | ${SHARE_DIR}/redis/data | Redis 数据目录 |
| NGINX_HTML_DIR | ${SHARE_DIR}/nginx/html | Nginx HTML 目录 |
| NGINX_LOG_DIR | ${SHARE_DIR}/nginx/logs | Nginx 日志目录 |
| NGINX_CONF_DIR | ${SHARE_DIR}/nginx/conf | Nginx 配置目录 |

---

## 启动命令

```bash
# 启动所有服务
docker-compose up -d

# 指定 PHP 模式
PHP70_MODE=swoole PHP71_MODE=fpm PHP80_MODE=fpm docker-compose up -d

# 切换 MySQL 版本
MYSQL_VERSION=8.0 docker-compose up -d

# 只启动特定服务组
docker-compose up -d php70-fpm nginx

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down
```

---

## 域名访问

| 域名 | 指向服务 |
|------|----------|
| localhost | Nginx 默认站点 |
| php70.localhost | PHP 7.0 站点 |
| php71.localhost | PHP 7.1 站点 |
| php80.localhost | PHP 8.0 站点 |

**注意：** 需要在本地 hosts 文件中添加域名解析：
```
127.0.0.1 localhost php70.localhost php71.localhost php80.localhost
```