# httpz

This is a project I am building to learn more about C and Zig.

My goal is to get to know more about Systems Programming languages and low level stuff, so I decided to build a lua library, using its C api.
Besides that, there are some projects I would like to build in lua (yes, using it as a standalone language), and I did not find a http client library simple enough to use, that's where I saw to opportunity to build my own inspired by the Python's [httpx](https://www.python-httpx.org/) interface.

## building
> pre-requisite: having Zig 0.13.0, Lua 5.4 and libcurl installed
In order to build this library, just clone it:
```sh
git clone https://github.com/ivansantiagojr/httpz.git
```

Change to the httpz directory:
```sh
cd httpz
```

And build the project:
```sh
zig build
```

This will compile the httpz lib to `zig-out/lib/libhttpz.so`, so, in order to use httpz from Lua we have place it in a path Lua can read it, we will do that by using the following command:
```sh
cp ./zig-out/lib/libhttpz.so ~/.luarocks/lib/lua/5.4/httpz.so
```

I have written a little shell script that runs the two previous commands, if you want to use it, feel free to:
```sh
./build_and_place_httpz.sh
```

Now, you can use it from Lua:
```lua
local httpz = require("httpz")

local response = httpz.get("https://httpbin.org/get")
print(response.status_code)
print(response.body)
```

The code above is also on `example/get.lua`, you can run the following command from the httpz directory:
```sh
lua examples/get.lua
```

useful links and sources that helped me:
- how to use curl YouTube playlist (I got the write_data function from here): [link](https://youtube.com/playlist?list=PLA1FTfKBAEX6p-lfk1l_Q2zh2E5wd-cup&si=-FO9rDDavFVTE5H_)
- using curl from Zig: [link](https://ziglang.org/learn/samples/#using-curl-from-zig)
- zig as a C compiler: [link](https://ziglang.org/learn/overview/#zig-is-also-a-c-compiler)
- the book Programmin in Lua, fourt edition, is teaching a lot of C and Lua.
- how to setup the `build.zig` for C projects: [link](https://www.reddit.com/r/Zig/comments/1cjtcc9/zig_013_fail_to_build_c_file/)

# Contributing
I want this project to be useful, but my main goal is to learn in the process of developing it, so if you want to contribute with the learning of those reading this or want to share what you have learned, you are more than welcome to open issues or send pull requests!

## Obs

I think there is no way in Zig to name the .so file however we want in build.zig: [reference](https://github.com/ziglang/zig/issues/2231
).

Is there a way to use the [lua-language-server](https://github.com/LuaLS/lua-language-server) to write the type definitions and stuff for this lib? I do not know, will still search for it.
