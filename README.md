# MinAtar

[![Build Status](https://travis-ci.com/mkschleg/MinAtar.jl.svg?branch=master)](https://travis-ci.com/mkschleg/MinAtar.jl)

A binding for [MinAtar](https://github.com/kenjyoung/MinAtar). Some weirdness w/ python but should be ok if your python environment is mostly clean. Visulization is supported through a Plots recipe and should be equivalent to the plotting in the python version (but you can use the underlying python version if you really want....). 

## Installation

```julia
]add MinAtar
```


## Some other weirdness:
- ~The state is returned from MinAtar as an Array of Float64s, where they really only need to be boolean. I'm talking w/ Kenny to maybe get this changed.~
- There may be some issues w/ the pip install. In travis we rarely get `openSSL` errors, but have no way of dealing with this. If you are using your local machine and have used python before you should be able to debug this issues yourself.



