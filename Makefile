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
	docker rm -f webtorch-test || true
	docker build -t webtorch .
	docker run --name webtorch-test -it webtorch sh test/run.sh
	@echo "========= WebTorch tests completed"

clean:
	rm -rf $(LIBS)

