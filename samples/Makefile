SRCS = 1_getstarted/init_smpl1.lua 1_getstarted/output_smpl1.lua
PREFIX = lib/
LUA = luajit
LUAFLAGS_DEV = -bg
LUAFLAGS = -b
LIBS_1 = $(addprefix $(PREFIX),$(notdir $(addsuffix .lbjc, $(basename $(SRCS)))))

all: init $(LIBS_1)

init:
	[ -d ./lib ] || mkdir ./lib

$(LIBS_1): $(SRCS)
	$(LUA) $(LUAFLAGS) $(addprefix 1_getstarted/,$(notdir $(addsuffix .lua, $(basename $@)))) $@
clean:
	rm -rf $(LIBS)
