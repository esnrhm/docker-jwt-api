local secret_key = os.getenv("SECRET_KEY")
local token = ngx.var.http_authorization  -- Get the token from the Authorization header

if not token then
    ngx.status = ngx.HTTP_UNAUTHORIZED
    ngx.say("No JWT token provided.")
    return ngx.exit(ngx.HTTP_UNAUTHORIZED)
end

-- Split the token into header, payload, and signature
local parts = {}
for part in token:gmatch("[^.]+") do
    table.insert(parts, part)
end

if #parts ~= 3 then
    ngx.status = ngx.HTTP_UNAUTHORIZED
    ngx.say("Invalid JWT token format.")
    return ngx.exit(ngx.HTTP_UNAUTHORIZED)
end

local encoded_header = parts[1]
local encoded_payload = parts[2]
local signature = parts[3]

-- Validate the signature
local expected_signature = ngx.encode_base64(ngx.hmac_sha1(secret_key, encoded_header .. "." .. encoded_payload))

if signature ~= expected_signature then
    ngx.status = ngx.HTTP_UNAUTHORIZED
    ngx.say("JWT token validation failed.")
    return ngx.exit(ngx.HTTP_UNAUTHORIZED)
end
