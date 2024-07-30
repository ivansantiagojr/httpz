#!/bin/bash

# building:
zig build

# copying the httpz.so shared lib in luarocks valid path
cp ./zig-out/lib/libhttpz.so ~/.luarocks/lib/lua/5.4/httpz.so
