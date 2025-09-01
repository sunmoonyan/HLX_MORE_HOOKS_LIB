# HLX_MORE_HOOKS_LIB
Add some hooks:
```lua
hook.Add("OnCharacterTransferred", "ExampleOnCharacterTransferred", function(self, faction)

hook.Add("CanAccessContainer", "ExampleCanAccessContainer", function(client, inventory, info)

hook.Add("OnContainerOpened", "ExampleOnContainerOpened", function(client, inventory, info)

hook.Add("OnContainerClosed", "ExampleOnContainerClosed", function(client, inventory, info)
```
