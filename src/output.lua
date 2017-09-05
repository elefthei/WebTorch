require "torch"
require "nn"
require "ngx"

-- print results
x = torch.Tensor(2)
x[1] =  0.5; x[2] =  0.5;
result = mlp:forward(x)

ngx.say(result:storage()[1])

