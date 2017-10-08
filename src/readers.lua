require "torch"
require "image"

-- Define deserializers
local deserializers = {}

-- Read tensor from request body
-- Assumes input has been validated
function deserializers.tensor(request_body)
  local file = torch.MemoryFile() -- creates a file in memory
  file:writeString(data)
  file:seek(1) -- comes back at the beginning of the file
  return file:readObject() -- gets a Tensor back (or any object sent)
end

-- Read tensor from request body
-- Assumes input has been validated
function deserializers.csv(request_body)
  local file = torch.MemoryFile() -- creates a file in memory
  file:writeString(data)
  file:seek(1) -- comes back at the beginning of the file
  return file:readObject() -- gets a Tensor back (or any object sent)
end

function deserializers.jpg(request_body)
  local file = torch.MemoryFile() -- creates a file in memory
  file:writeString(data)
  file:seek(1) -- comes back at the beginning of the file
  return file:readObject() -- gets a Tensor back (or any object sent)
end

function deserializers.png(request_body)
  local file = torch.MemoryFile() -- creates a file in memory
  file:writeString(request_body)
  file:seek(1) -- comes back at the beginning of the file
  return file:readObject() -- gets a Tensor back (or any object sent)
end

function deserializers.bmp(request_body)
  local file = torch.MemoryFile() -- creates a file in memory
  file:writeString(request_body)
  file:seek(1) -- comes back at the beginning of the file
  return file:readObject() -- gets a Tensor back (or any object sent)
end



