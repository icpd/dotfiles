-- Proxy configuration for Kaku terminal
-- Toggle proxy by changing `enabled` to true/false
-- kaku.lua :
-- local proxy = dofile(wezterm.config_dir .. '/proxy.lua')
-- proxy.apply(config)

local M = {}

local proxy_enabled = true -- <-- change this to enable/disable proxy

local proxy_host = '127.0.0.1'
local proxy_port = 7890

local function command_succeeds(cmd)
    local ok, why, code = os.execute(cmd)
    if type(ok) == 'number' then
        return ok == 0
    end
    return ok == true and why == 'exit' and code == 0
end

local function local_port_open(host, port)
    local cmd = string.format(
        "/bin/bash -lc 'exec 3<>/dev/tcp/%s/%d' >/dev/null 2>&1",
        host,
        port
    )
    return command_succeeds(cmd)
end

function M.apply(config)
    if not proxy_enabled then return end
    local proxy_url = string.format('http://%s:%d', proxy_host, proxy_port)
    if local_port_open(proxy_host, proxy_port) then
        config.set_environment_variables = config.set_environment_variables or {}
        config.set_environment_variables.all_proxy = proxy_url
        config.set_environment_variables.ALL_PROXY = proxy_url
        config.set_environment_variables.http_proxy = proxy_url
        config.set_environment_variables.HTTP_PROXY = proxy_url
        config.set_environment_variables.https_proxy = proxy_url
        config.set_environment_variables.HTTPS_PROXY = proxy_url
    end
end

return M
