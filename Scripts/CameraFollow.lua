local CameraFollow =
{
    -- delay before camera starts to follow
    delay = 1.0,
    timer = 0.0,
    -- Smoothing
    followSpeed = 5.0,
    -- offset from player
    offset = Vector3.new(0, 5, -10),
    following = false,
    player = nil,
    playerTransform = nil,
    transform = nil
}

function CameraFollow:OnStart()
    self.transform = self.owner:GetTransform()
    local scene = Scenes.GetCurrentScene()
    if scene ~= nil then
        self.player = scene:FindActorByTag("Player")
        if self.player ~= nil then
            self.playerTransform = self.player:GetTransform()
        end
    end
end

function CameraFollow:OnUpdate(deltaTime)
    -- short delay before camera follows
    if not self.following then
        self.timer = self.timer + deltaTime
        if self.timer >= self.delay then
            self.following = true
        end
        return
    end

    -- Aquire Player actor
    if self.player == nil then
        local scene = Scenes.GetCurrentScene()
        if scene ~= nil then
            self.player = scene:FindActorByTag("Player")
        end
    end

    -- Refresh players transform every frame
    if self.player ~= nil then
        local newTransform = self.player:GetTransform()
        if newTransform ~= nil then
            self.playerTransform = newTransform
        end
    end

    -- Camera Follow logic
    if self.transform ~= nil and self.playerTransform ~= nil then
        local targetPos = self.playerTransform:GetPosition() + self.offset
        local currentPos = self.transform:GetPosition()

        local newPos = currentPos + (targetPos - currentPos) * self.followSpeed * deltaTime
        self.transform:SetPosition(newPos)
    end

end

return CameraFollow
