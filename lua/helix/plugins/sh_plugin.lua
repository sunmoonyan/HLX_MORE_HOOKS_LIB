local PLUGIN = PLUGIN

PLUGIN.name = "Helix More Hook Lib"
PLUGIN.author = "Sunshi"
PLUGIN.description = "Add more hooks to the helix framework."

if SERVER then
    local character = ix.meta.character

    local _oldSetFaction = character.SetFaction

    function character:SetFaction(faction, ...)
      _oldSetFaction(self, faction, ...)
      hook.Run("OnCharacterTransferred", self, faction)
    end

    local realOpen = ix.storage.Open

    function ix.storage.Open(client, inventory, info)
        info = info or {}
        
        if hook.Run("CanAccessContainer", client, inventory, info) != false then

        info.OnPlayerClose = function(ply)
            hook.Run("OnContainerClosed", ply, inventory, info)
        end

        if not ix.storage.InUse(inventory) then
            hook.Run("OnContainerOpened", client, inventory, info)
        end

        return realOpen(client, inventory, info)

        end
    end


local area = ix.plugin.list["area"]

if area then
    
function area:AreaThink()
    for _, client in player.Iterator() do
        local character = client:GetCharacter()

        if (!client:Alive() or !character) then
            continue
        end

        local overlappingBoxes = {}
        local position = client:GetPos() + client:OBBCenter()

        for id, info in pairs(ix.area.stored) do
            if (position:WithinAABox(info.startPosition, info.endPosition)) then
                overlappingBoxes[#overlappingBoxes + 1] = id
            end
        end

        if (#overlappingBoxes > 0) then
            local oldID = client:GetArea()
            local id = overlappingBoxes[1]
            if (oldID != id) then
                hook.Run("OnPlayerAreaChanged", client, client.ixArea, id)
                client.ixArea = id
            end
            client.ixInArea = true
        else
            client.ixInArea = false
            client.ixArea = ""
            hook.Run("OnPlayerAreaChanged", client, "", "")
        end
    end
end

end




else


end