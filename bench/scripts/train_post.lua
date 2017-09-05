-- example HTTP POST script which demonstrates setting the
-- HTTP method, body, and adding a header
wrk.method = "POST"
wrk.body   = string.format([[
4
1
3
V 1
18
torch.DoubleTensor
1
2
1
1
4
2
3
V 1
19
torch.DoubleStorage
2
%f %f
]], math.random(), math.random())
wrk.headers["Content-Type"] = "text/plain"
