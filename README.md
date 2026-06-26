# OF-docker tools

## 集成OF docker开发环境

## common tools

### 测试端口是否可以访问
```bash
docker run --rm busybox sh -c "nc -zv -w 3 iscsdbt-0.iscsdbt.dev.svc.test.yafex.net 3306 && echo ' 端口可达' || echo ' 端口不可达或超时'"
```