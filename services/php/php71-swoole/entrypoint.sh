#!/bin/bash

# SWOOLE_SCRIPT 为空时容器保持运行，进入容器手动执行脚本
if [ -n "$SWOOLE_SCRIPT" ]; then
    echo "Starting Swoole script: $SWOOLE_SCRIPT"
    exec php "$SWOOLE_SCRIPT" "$@"
else
    echo "Swoole container ready. Use 'docker exec -it php71-swoole bash' to run your scripts."
    tail -f /dev/null
fi
