require "torch"
require "nn"
require "ngx"

local webtensor = {}

function webtensor.recv()
  -- Read tensor from request body
  ngx.req.read_body()  -- explicitly read the req body
  local data = ngx.req.get_body_data()
  if not data then
    ngx.status = ngx.HTTP_BAD_REQUEST
    ngx.say("Body not found")
    -- to cause quit the whole request rather than the current phase handler
    ngx.exit(ngx.HTTP_BAD_REQUEST)
    return nil
  end

  local file = torch.MemoryFile() -- creates a file in memory
  file:writeString(data)
  file:seek(1) -- comes back at the beginning of the file
  return file:readObject() -- gets a Tensor back (or any object sent)
end

-- Load the mlp from shared memory
local mlp = ngx.shared.mlp

-- Mean squared error criterion
criterion = nn.MSECriterion()

-- Receive tensor from request body if POST or rand if GET
local input = nil
if ngx.req.get_method() == "POST" then
	input = webtensor.recv()
else
	input = torch.randn(2)
end

-- Train with XOR'd output
local output = torch.Tensor(1)
if input[1]*input[2] > 0 then  -- calculate label for XOR function
  output[1] = -1
else
  output[1] = 1
end

-- feed it to the neural network and the criterion
criterion:forward(mlp:forward(input), output)

-- train over this example in 3 steps
-- (1) zero the accumulation of the gradients
mlp:zeroGradParameters()
-- (2) accumulate gradients
mlp:backward(input, criterion:backward(mlp.output, output))
-- (3) update parameters with a 0.01 learning rate
mlp:updateParameters(0.01)

-- Save the mlp to shared memory
ngx.say(string.format("Trained with random (%f, %f)", input[1], input[2]))
ngx.shared.mlp = mlp
