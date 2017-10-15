----------------------------------------------------------------------
-- getstarted.lua
-- 
-- This script demonstrates very basic Lua/Torch stuff.

require "torch"
require "nn"
require "ngx"
require "image"

----------------------------------------------------------------------
-- snippet 1
ngx.say('basic printing')
a = 10
ngx.say(a)
ngx.say 'something'
ngx.say(type(a))
ngx.say(type('something'))


----------------------------------------------------------------------
-- snippet 2
image = require 'image'
i = image.lena()
ngx.say("image loaded")

----------------------------------------------------------------------
-- snippet 5
-- loading network and image from shared memory
local n = ngx.shared.n

res = n:forward(image.rgb2y(i))

ngx.say("image successfully converted from rgb to Y color space");