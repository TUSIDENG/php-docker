# PHP Docker 多环境开发平台

## 📖 项目简介

本项目提供了一个基于 Docker 的完整 PHP 开发环境，支持多版本 PHP（7.4-8.3）、Elasticsearch 集群、以及常用的基础设施服务（Nginx、MySQL、Redis）。通过服务组隔离和独立网络，实现了灵活、高效、可扩展的本地开发环境。

## 🎯 核心特性

- **多版本 PHP 支持**：同时提供 PHP 7.4、8.0、8.1、8.2、8.3 五个版本，方便项目切换
- **服务组隔离**：PHP、ES、Common 三大服务组独立管理，互不干扰
- **统一网络通信**：所有服务组通过 Docker 网络互联，实现服务发现
- **完整的调试支持**：集成 Xdebug 3.x，支持 FPM 和 Swoole 双模式调试
- **数据持久化**：MySQL、Redis、ES 数据持久化存储
- **生产级配置**：提供优化的生产环境配置模板
- **一键启停**：配套管理脚本，简化操作流程

## 📦 服务组说明

### 1. PHP 服务组 (php)
| 服务 | 版本 | 说明 |
|------|------|------|
| php7.4-fpm | 7.4.33 | 支持 Xdebug、Swoole 5.x |
| php8.0-fpm | 8.0.30 | 支持 Xdebug、Swoole 5.x |
| php8.1-fpm | 8.1.27 | 支持 Xdebug、Swoole 5.x |
| php8.2-fpm | 8.2.18 | 支持 Xdebug、Swoole 5.x |
| php8.3-fpm | 8.3.6 | 支持 Xdebug、Swoole 5.x |

**内置扩展**：
- PDO MySQL / Redis / PostgreSQL
- Redis (phpredis)
- Swoole (5.x)
- Xdebug (3.x)
- Composer 2.x
- 常用工具：git、unzip、vim、curl

### 2. Elasticsearch 服务组 (es)
| 服务 | 版本 | 说明 |
|------|------|------|
| Elasticsearch | 8.11.0 | 支持全文搜索和分析 |
| Kibana | 8.11.0 | ES 可视化管理和查询工具 |

### 3. 公共服务组 (common)
| 服务 | 版本 | 说明 |
|------|------|------|
| Nginx | 1.25.x | 高性能 Web 服务器 |
| MySQL | 8.0.x | 关系型数据库 |
| Redis | 7.2.x | 缓存和消息队列 |
| BusyBox | latest | 网络诊断和调试工具 |

## 🚀 快速开始

### 环境要求
- Docker Engine >= 20.10.0
- Docker Compose >= 2.20.0
- 至少 4GB 可用内存（推荐 8GB+）

### 测试端口是否可以访问
```bash
docker run --rm busybox sh -c "nc -zv -w 3 iscsdbt-0.iscsdbt.dev.svc.test.yafex.net 3306 && echo ' 端口可达' || echo ' 端口不可达或超时'"
```