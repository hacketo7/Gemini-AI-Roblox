--Turn on HTTP Requests in security settings of your game for this code to work.

local httpService = game:GetService("HttpService")

local ApiKey = "" --Put your API Key here.
local endpoint =
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" .. ApiKey --The endpoint may be outdated, be cautious.

if ApiKey == "" then
    print("Please get an API Key from Google Studio.")
    return
end

local function callGemini(msg)
    --request
    local requestBody = {
        contents = {
            parts = {
                text = msg
            }
        }
    }

    local jsonEncode = httpService:JSONEncode(requestBody)

    --error detection and request to google servers
    local success, response =
        pcall(
        function()
            return httpService:PostAsync(endpoint, jsonEncode, Enum.HttpContentType.ApplicationJson, false)
        end
    )

    --if request was sent
    if success then
        local data = httpService:JSONDecode(response)

        local answer = data.candidates and data.candidates[1] and data.candidates[1].content.parts[1].text or "No reply"
        return answer
    else
        warn(response)
        return response
    end
end

--Example Usage:
answer = callGemini("hi")
print(answer)
