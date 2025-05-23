local BallController =
{
    speed = 8.0
}

function BallController:OnStart()
    self.transform = self.owner:GetTransform()
end

function BallController:OnUpdate(deltaTime)
    local moveX = 0
    local moveZ = 0

    if Inputs.GetKey(Key.W) or Inputs.GetKey(Key.UP) then
        moveZ = moveZ + 1
    end
    if Inputs.GetKey(Key.S) or Inputs.GetKey(Key.DOWN) then
        moveZ = moveZ - 1
    end
    if Inputs.GetKey(Key.A) or Inputs.GetKey(Key.LEFT) then
        moveX = moveX + 1
    end
    if Inputs.GetKey(Key.D) or Inputs.GetKey(Key.RIGHT) then
        moveX = moveX - 1
    end

    local dir = Vector3.new(moveX, 0, moveZ)
    local pos = self.transform:GetPosition()
    pos = pos + dir * self.speed * deltaTime
    self.transform:SetPosition(pos)
end

return BallController
