-- [[ 1. สร้าง UI และตั้งค่าให้ตายแล้วไม่หาย ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NoclipUI_Kuya"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false -- ตายแล้ว UI ยังอยู่
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [[ 2. สร้างหน้าต่างหลัก (ลากได้) ]]
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -75, 0.5, -50)
MainFrame.Size = UDim2.new(0, 150, 0, 100)
MainFrame.Active = true
MainFrame.Draggable = true -- ทำให้ลากได้อิสระ

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "KUYA NOCLIP"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

-- [[ 3. ปุ่มเปิด/ปิด Noclip ]]
local ToggleBtn = Instance.new("TextButton", MainFrame)
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Text = "NOCLIP: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold

local BtnCorner = Instance.new("UICorner", ToggleBtn)
BtnCorner.CornerRadius = UDim.new(0, 6)

-- [[ 4. ระบบ Noclip Logic ]]
local NoclipEnabled = false
local RunService = game:GetService("RunService")

-- ฟังก์ชันที่ทำงานทุกเฟรมเพื่อปิดแรงกระแทก (Collision)
RunService.Stepped:Connect(function()
    if NoclipEnabled then
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false -- ปิดการชนกันเพื่อให้เดินทะลุได้
                end
            end
        end
    end
end)

-- ปุ่มคลิกเพื่อเปิด/ปิด
ToggleBtn.MouseButton1Click:Connect(function()
    NoclipEnabled = not NoclipEnabled
    if NoclipEnabled then
        ToggleBtn.Text = "NOCLIP: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        ToggleBtn.Text = "NOCLIP: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        -- เมื่อปิด ให้กลับมาเดินปกติทันที
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

print("Noclip Script Loaded! 🗿🥊")
