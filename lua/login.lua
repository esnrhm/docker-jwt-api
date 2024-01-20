local username = os.getenv("USERNAME")
local password = os.getenv("PASSWORD")
local secret_key = os.getenv("SECRET_KEY")


ngx.req.read_body()
local body_data = ngx.req.get_body_data()
if body_data then
    -- Define a function to manually parse JSON string
    local function parse_json(json_str)
        local json_table = {}
        for key, value in json_str:gmatch('"([^"]+)":%s*"(.-)"') do
            json_table[key] = value
        end
        return json_table
    end

    -- Convert the request body data to a Lua table
    local json_table = parse_json(body_data)

    if json_table["username"] then
        if json_table["password"] then
            if json_table["username"] == username and json_table["password"] == password then
ngx.log(ngx.ERR, "login success")
            else
ngx.say("Invalid username or password.")
return ngx.exit(ngx.HTTP_UNAUTHORIZED)
            end
        else
            ngx.say("Key 'password' not found.")
            return ngx.exit(ngx.HTTP_UNAUTHORIZED)
        end
    else
        ngx.say("Key 'username' not found.")
        return ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end   
else
    ngx.say("No request body data found.")
    return ngx.exit(ngx.HTTP_UNAUTHORIZED)
end


-- Payload for the JWT token
local payload = {
    iss = "issuer",
    sub = "subject",
    exp = ngx.time() + 36000,  -- Set expiration time to 10 hour from now
}

-- Encode the JWT token
local encoded_header = ngx.encode_base64('{"typ":"JWT","alg":"HS256"}')
local encoded_payload = ngx.encode_base64(ngx.escape_uri(ngx.encode_args(payload)))
local signature = ngx.encode_base64(ngx.hmac_sha1(secret_key, encoded_header .. "." .. encoded_payload))

local jwt_token = encoded_header .. "." .. encoded_payload .. "." .. signature

ngx.say(jwt_token)