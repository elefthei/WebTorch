#!/bin/sh
nginx
luajit test/test.lua
nginx -s stop
