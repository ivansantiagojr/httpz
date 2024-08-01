local httpz = require("httpz")

local response = httpz.get("https://httpbin.org/get")
print(response.status_code)
print(response.body)
