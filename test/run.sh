#!/bin/sh
echo "============= Running WebTorch server"
nginx
echo "============= Running WebTorch server tests"
luajit test/test.lua

