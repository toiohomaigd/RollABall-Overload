local PickupController =
{
    spinSpeed = 60.0 -- degrees per second

}

function PickupController:OnStart()
    self.transform = self.owner:GetTransform()

    -- Get mesh from child object
    local children = self.owner:GetChildren()
    if #children > 0 then
        self.meshActor = children[1]
        self.meshTransform = self.meshActor:GetTransform()
    end
end

function PickupController:OnUpdate(deltaTime)
    if self.meshTransform ~= nil then
        -- set rotation for each axis 
        self.rotationX = (self.rotationX or 0) + self.spinSpeed * deltaTime
        self.rotationY = (self.rotationY or 0) + self.spinSpeed * deltaTime

        local radX = math.rad(self.rotationX)
        local radY = math.rad(self.rotationY)
        
        -- Computer quaternions for each axis
        local sinHalfX = math.sin(radX / 2)
        local cosHalfX = math.cos(radX / 2)
        local sinHalfY = math.sin(radY / 2)
        local cosHalfY = math.cos(radY / 2)

        -- compute the quaternions
        local quatX = Quaternion.new(sinHalfX, 0, 0, cosHalfX)
        local quatY = Quaternion.new(0, sinHalfY, 0, cosHalfY)

        -- Combine rotations X * Y
        local finalQuat = quatY * quatX
        self.meshTransform:SetRotation(finalQuat)
    end
end

return PickupController
