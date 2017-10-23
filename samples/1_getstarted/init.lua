----------------------------------------------------------------------
-- getstarted
--
-- initialization script: store image and neural network in nginx shared memory

require "torch"
require "nn"
require "ngx"
require "image"


----------------------------------------------------------------------
-- snippet 4
n = nn.SpatialConvolution(1,16,12,12)
ngx.shared.n = n



