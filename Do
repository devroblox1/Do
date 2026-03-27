local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local aimRange = 100
local smoothness = 0.15

function getClosestTarget()
    local closest = nil
    local shortest = aimRange

    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pos = p.Character.HumanoidRootPart.Position
            local distance = (pos - player.Character.HumanoidRootPart.Position).Magnitude
            
            if distance < shortest then
                shortest = distance
                closest = p.Character.HumanoidRootPart
            end
        end
    end

    return closest
end

game:GetService("RunService").RenderStepped:Connect(function()
    local target = getClosestTarget()
    
    if target then
        local direction = (target.Position - camera.CFrame.Position).Unit
        local newCF = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + direction)
        
        camera.CFrame = camera.CFrame:Lerp(newCF, smoothness)
    end
end)
