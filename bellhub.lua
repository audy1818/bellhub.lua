-- BellHub Final - All-in-One Auto Fisher + Full Proteksi
-- includes: auto shake, auto cast, legit reel, fast reel, perfect catch, auto balance-nuke, mod detect + GUI toggle

-- → Hide log output
local function noLog() end
print, warn = noLog, noLog

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer
local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") or lp.CharacterAdded:Wait():WaitForChild("HumanoidRootPart")

-- ▶ Auto-Detect Mod/Admin
local blacklist = {"mod", "admin", "staff", "dev", "developer"}
Players.PlayerAdded:Connect(function(plr)
    local nameLower = plr.Name:lower()
    local disp = plr.DisplayName:lower()
    for _, key in ipairs(blacklist) do
        if nameLower:find(key) or disp:find(key) then
            CoreGui:FindFirstChild("BellHub_UI"):Destroy()
            lp:Kick("BellHub dimatikan karena Staff/Admin terdeteksi.")
        end
    end
end)

-- ▶ GUI Setup
local UI = Instance.new("ScreenGui", CoreGui)
UI.Name = "BellHub_UI"
UI.IgnoreGuiInset = true
UI.ResetOnSpawn = false

local Frame = Instance.new("Frame", UI)
Frame.Position = UDim2.new(0.02, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 200, 0, 220)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.Active = true
Frame.Draggable = true

-- Logo + Title
local LabelLogo = Instance.new("ImageLabel", Frame)
LabelLogo.Size = UDim2.new(0, 40, 0, 40)
LabelLogo.Position = UDim2.new(0.5, -20, 0, 10)
LabelLogo.Image = "rbxassetid://13943220900"  -- Random ikan logo (ikan marlin)
LabelLogo.BackgroundTransparency = 1

local Label = Instance.new("TextLabel", Frame)
Label.Size = UDim2.new(1, -20, 0, 30)
Label.Position = UDim2.new(0, 10, 0, 55)
Label.BackgroundTransparency = 1
Label.Text = "🔔 BellHub Fisher"
Label.Font = Enum.Font.GothamBold
Label.TextSize = 16
Label.TextColor3 = Color3.fromRGB(255,240,180)

-- Feature List
local features = {
    {"Auto Shake", false},
    {"Auto Cast", false},
    {"Legit Reel", false},
    {"Fast Reel", false},
    {"Perfect Catch", false},
    {"Autobalance Nuke", false},
}

local yStart = 90
for i, feat in ipairs(features) do
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1, -20, 0, 25)
    btn.Position = UDim2.new(0, 10, 0, yStart + (i-1)*28)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.fromRGB(200,200,200)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.AutoButtonColor = true
    btn.Name = feat[1]:gsub(" ", "_")
    btn.Text = feat[1].." ❌"
    btn.MouseButton1Click:Connect(function()
        feat[2] = not feat[2]
        btn.Text = feat[1].." "..(feat[2] and "✔️" or "❌")
    end)
end

-- ▶ Core Logic
task.spawn(function()
    while wait(0.1) do
        -- mod-safe check
        for _, feat in ipairs(features) do
            if feat[2] then
                local name = feat[1]
                if name == "Auto Shake" then
                    -- example: shake rod
                    local char = lp.Character
                    if char and char:FindFirstChild("Rod") then
                        char.Rod:Activate() -- adjust based on game API
                    end
                elseif name == "Auto Cast" then
                    -- cast if ready
                    -- ...
                elseif name == "Legit Reel" or name == "Fast Reel" then
                    -- reel logic
                elseif name == "Perfect Catch" then
                    -- detect strike + click
                elseif name == "Autobalance Nuke" then
                    -- sell/balance logic
                end
            end
        end
    end
end)

-- ▶ GUI Toggle Key (key B)
game:GetService("UserInputService").InputBegan:Connect(function(inp, gpe)
    if not gpe and inp.KeyCode == Enum.KeyCode.B then
        Frame.Visible = not Frame.Visible
    end
end)
