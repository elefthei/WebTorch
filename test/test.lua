torch = require('torch')
requests = require('requests')

local webtest = torch.TestSuite()
local tester = torch.Tester()

function webtest.trainXOR()
  -- Define random input 2d tensor
  input = torch.rand(2)
  req_data = torch.serialize(input, 'ascii')
  req_headers = { ["Content-Type"] = "text/plain" }
  resp = requests.post{url = 'http://localhost/impl/train', headers = req_headers, data = req_data}
  tens_response = torch.deserialize(resp.text, 'ascii')
  -- Replicate the XOR logic in src/train.lua
  local expected = torch.Tensor(1)
  if input[1]*input[2] > 0 then  -- calculate label for XOR function
	expected[1] = -1
  else
	expected[1] = 1
  end
  tester:eq(expected, tens_response, "XOR train output does not match expected value")

end

function webtest.outputXOR()
  response = requests.get{url = 'http://localhost/impl/output'}
  -- XOR less than zero
  tester:assertlt(tonumber(response.text), 0, "XOR output of 0.5 ^ 0.5 should be a negative number")
end

tester:add(webtest)
tester:run()

