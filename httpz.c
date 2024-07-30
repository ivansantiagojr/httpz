#include <curl/curl.h>
#include <lauxlib.h>
#include <lua.h>
#include <lualib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *string;
    size_t size;
} Response;

size_t write_callback(void *data, size_t size, size_t nmemb, void *user_data) {
    size_t real_size = size * nmemb;
    Response *response = (Response *)user_data;

    char *ptr = realloc(response->string, response->size + real_size + 1);

    if (ptr == NULL) {
        return CURL_WRITEFUNC_ERROR;
    }

    response->string = ptr;
    memcpy(&(response->string[response->size]), data, real_size);

    response->size += real_size;

    response->string[response->size] = 0; // '\0';

    return real_size;
}

static int l_http_get(lua_State *L) {
    const char *url = luaL_checkstring(L, 1);

    CURL *curl;
    CURLcode res;
    long http_status_code = 0;
    Response response_body;
    response_body.string = malloc(1);
    response_body.size = 0;

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)&response_body);

        res = curl_easy_perform(curl);

        curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &http_status_code);

        curl_easy_cleanup(curl);
    }

    curl_global_cleanup();

    lua_newtable(L);
    lua_pushstring(L, "response");
    lua_pushstring(L, response_body.string);
    lua_settable(L, -3);

    lua_pushstring(L, "status_code");
    lua_pushinteger(L, http_status_code);
    lua_settable(L, -3);

    return 1;
}

static const struct luaL_Reg httpz_lib[] = {{"get", l_http_get}, {NULL, NULL}};

int luaopen_httpz(lua_State *L) {
    luaL_newlib(L, httpz_lib);
    return 1;
}
