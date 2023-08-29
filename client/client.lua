local QBCore = exports['qb-core']:GetCoreObject()
local lib = exports.ox_lib

-- Net Events
RegisterNetEvent('vista-recycleCenter:openMenu')
AddEventHandler('vista-recycleCenter:openMenu', function ()
    lib.showMenu('recycleMenu')
end)

if Config.debug then
    RegisterCommand('testRecycleMenu', function()
        lib.showMenu('recycleMenu')
    end)
end

-- FUNCTIONS

    -- Menu Creation
function createMenu()
    local options = {
        {label = 'Simple button', description = 'It has a description!'},
    }
    lib.registerMenu({
        id = 'recycleMenu',
        title = 'Recycling Center',
        position = 'top-right',
        options = options
    }, function()
    end)
end

    -- Ped Creation
TriggerEvent('ox_target:load')
function createRecyclePed()
    local ped = CreatePed(4, GetHashKey(Config.pedModel), Config.pedCoords.x, Config.pedCoords.y, Config.pedCoords.z, 0.0, false, true)
    local targetData = {
        name = "Recycle Man",
        position = Config.pedCoords, 
        radius = 1.0, 
        options = {
            {
                name = "Interact",
                event = "vista-recycleCenter:openMenu" 
            }
        }
    }
    TriggerEvent("ox_target:addEntity", ped, targetData)
end




AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    print('The resource ' .. resourceName .. ' has been started.')
    createMenu()
    createRecyclePed()
    if Config.debug then
        print("Debug Mode is enabled")
    end
  end)

