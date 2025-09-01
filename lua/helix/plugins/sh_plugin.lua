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

else


end