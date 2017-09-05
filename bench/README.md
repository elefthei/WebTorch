# Benchmarks

## Wrk
Wrk is a load-balance tester tool written in LuaJIT. It was executed with the following options:

`wrk -t12 -c400 -d30s http://localhost:3000/<endpoint>`

This runs a benchmark for 30 seconds, using 12 threads, and keeping 400 HTTP connections open.

## Benchmarks were done on a Macbook Air with the following specs:
```
Model Name:	MacBook Air
  Model Identifier:	MacBookAir6,2
  Processor Name:	Intel Core i5
  Processor Speed:	1.3 GHz
  Number of Processors:	1
  Total Number of Cores:	2
  L2 Cache (per Core):	256 KB
  L3 Cache:	3 MB
  Memory:	4 GB
  Boot ROM Version:	MBA61.0099.B51
  SMC Version (system):	2.13f15
```

## Results:

Here's the results:
```
benchmarks/
├── output_cache_off_bytecode_on.txt
├── output_cache_on_bytecode_on.txt
├── train_cache_off_bytecode_off.txt
├── train_cache_off_bytecode_on.txt
├── train_cache_on_bytecode_off.txt
└── train_cache_on_bytecode_on.txt
```

Currently output is using `ngx.say` which does not allow for bytecode linking. One more experiment left is static linking.


