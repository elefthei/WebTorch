APP_1 = 1_getstarted
SRCS_1 = $(APP_1)/init.lua $(APP_1)/output.lua
PREFIX = lib/
LUA = luajit
LUAFLAGS_DEV = -bg
LUAFLAGS = -b
LIBS_1 = $(addprefix $(PREFIX)$(APP_1)/,$(notdir $(addsuffix .lbjc, $(basename $(SRCS_1)))))

all: init $(LIBS_1)

init:
	[ -d ./lib ] || (mkdir -p ./lib && mkdir -p ./lib/$(APP_1))

$(LIBS_1): $(SRCS_1)
	$(LUA) $(LUAFLAGS) $(addprefix $(APP_1)/,$(notdir $(addsuffix .lua, $(basename $@)))) $@
	
clean:
	rm -rf $(LIBS)
