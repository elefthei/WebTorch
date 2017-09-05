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
clean:
	rm -rf $(LIBS)
