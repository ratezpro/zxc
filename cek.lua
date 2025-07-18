local HttpService = game:GetService("HttpService")
local Request = (syn and syn.request) or request or (http and http.request) or http_request
local username = game.Players.LocalPlayer.Name

game.StarterGui:SetCore("SendNotification", {
    Title = 'SERVICES Ready',
    Text = 'User : ' .. username,
})

local currentStatus = "online"
game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(v)
    if v.Name == "ErrorPrompt" then
        if currentStatus ~= "offline" then
            currentStatus = "offline"
            sendStatus("offline")
        end
    end
end)

function sendStatus(status)
    local url = "http://10.0.2.2:5618/"
    local data = "username=" .. username .. "&status=" .. status
    local requestData = {
        Url = url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/x-www-form-urlencoded"
        },
        Body = data
    }
    local success, response = pcall(function()
        return Request(requestData)
    end)
    if success and response.StatusCode == 200 then
        print("Status Sent: " .. status .. " (User: " .. username .. ")")
    else
        warn("Failed to send status: " .. (response and response.StatusCode or "Request failed"))
    end
end
local Round = 0
wait(2)
while true do
    if currentStatus == "online" then
        sendStatus("online")
    end
    Round += 1
    wait(20)
end
