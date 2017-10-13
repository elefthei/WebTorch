torch = require('torch')
requests = require('requests')

describe("Webtorch integration tests", function()
  describe("Torch tests", function()
    it("Make sure Torch was installed", function()
      tensor = torch.Tensor(4,5)
      assert.are.equal(tensor:nDimension(), 2)
    end)
  end)

  describe("WebTorch train tests", function()
    it("It should be able to train with POST", function()
      numbers = torch.rand(2)
      response = requests.post{url = 'http://localhost:3000/train', data = torch.serialize(numbers)}
      print(response.text)
    end)
  end)

  describe("WebTorch output tests", function()
    it("It should be able to output with GET", function()
      response = requests.get{url = 'http://localhost:3000/output'}
      -- XOR less than zero
      assert.True(tonumber(response.text) < 0)
    end)
  end)

end)

