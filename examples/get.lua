local httpz = require("httpz")

local response = httpz.get("https://example.com")
print(response.status_code)
print(response.body)
