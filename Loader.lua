local config = _G.MoonDropper

if game.PlaceId ~= 2788229376 then
    messagebox("You are not in the correct game, please ensure you are in 'Da Hood'.", "Moon", 0)
    error("You are not in the correct game, please ensure you are in 'Da Hood'.")
    return
end

for _,v in pairs(config.Controllers) do
    if not (tostring(game.Players.LocalPlayer.UserId) == tostring(v)) then
           setfpscap(5)
           game:GetService("RunService"):Set3dRenderingEnabled(false)
    else
           setfpscap(120)
           game:GetService("RunService"):Set3dRenderingEnabled(true)
    end
 end

print("Loading Commands...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/toxinsfx/MoonDropper/main/Commands.lua",true))()
print("Commands Loaded!")

local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer.Character ~= nil

print("Loading Command Handler...")

function Command(player, msg)
     cmd = string.split(msg," ")
     print("Controller chatted: " .. cmd[1])
     if(string.sub(string.lower(cmd[1]),1,1) == config.Prefix) then
          cmd1 = string.lower(cmd[1]):gsub(config.Prefix, "")
         if(_G.MoonCommands[cmd1] ~= nil) then
             print("Running Command " .. cmd1 .. "...")
             _G.MoonCommands[cmd1]({cmd[2], cmd[3], cmd[4], cmd[5], cmd[6], cmd[7], cmd[8], cmd[9], cmd[10], cmd[11]}, player)
         end
     end
end

game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Data)
    local Player = game:GetService("Players")[Data.FromSpeaker]
    local Message = Data.Message
    local Channel = Data.OriginalChannel
        
     for _,v in pairs(config.Controllers) do
       if(tostring(Player.UserId) == tostring(v)) then
              Command(Player, Message)
        end
    end
end)

print("Command Handler ready.")

print("Loading Libraries...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/PickleIsDaBest/Min/main/Skript"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/diz-zzyy/AgonyDropper/main/scripts/DeleteChairs.lua"))()
print("Libraries loaded.")
print("Moon loaded!")

game.StarterGui:SetCore("SendNotification", {
        Title = "Moon";
        Text = "Moon has loaded!";
        Duration = 10;
})
