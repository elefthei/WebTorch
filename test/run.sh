#!/bin/sh
echo "============= Running WebTorch server"
nginx
echo "============= Running WebTorch server tests"
luajit test/test.lua
echo "============= WebTorch server tests finished, stopping server..."
nginx -s stop
