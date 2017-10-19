.PHONY: all init test clean
SRCS = src/train.lua src/output.lua src/init.lua
PREFIX = lib/
LUA = luajit
LUAFLAGS_DEV = -bg
LUAFLAGS = -b
LIBS = $(addprefix $(PREFIX),$(notdir $(addsuffix .lbjc, $(basename $(SRCS)))))

all: init $(LIBS)

init:
	[ -d ./lib ] || mkdir ./lib

$(LIBS): $(SRCS)
	$(LUA) $(LUAFLAGS) $(addprefix src/,$(notdir $(addsuffix .lua, $(basename $@)))) $@

test:
	@echo "========= Building WebTorch docker image"
	docker rm -f webtorch-test 2>&1 > /dev/null || true
	docker build -qt webtorch .
	docker run --name webtorch-test -t webtorch sh test/run.sh
	docker rm -f webtorch-test 2>&1 > /dev/null || true
	@echo "========= WebTorch tests completed"

clean:
	rm -rf $(LIBS)

