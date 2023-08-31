local QBCore = exports['qb-core']:GetCoreObject()


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

function dprint(debugPrint) -- Debug print function that only prints if debug mode is enabled
    if Config.debug then
        print(debugPrint)
    end
end

    -- Menu Creation
function createMenu()
    local options = {
        {label = 'Trade Voucher for Iron', description = 'It has a description!', args = {mat = 'iron'}},
        {label = 'Trade Voucher for Copper', description = 'It has a description!', args = {mat = 'copper'}},
        {label = 'Trade Voucher for Aluminium', description = 'It has a description!', args = {mat = 'aluminium'}},
        {label = 'Trade Voucher for Steel', description = 'It has a description!', args = {mat = 'steel'}},
        {label = 'Trade Voucher for Metalscrap', description = 'It has a description!', args = {mat = 'metalscrap'}},
        {label = 'Trade Voucher for Rubber', description = 'It has a description!', args = {mat = 'rubber'}},
        {label = 'Trade Voucher for Brass', description = 'It has a description!', args = {mat = 'brass'}},
        {label = 'Trade Voucher for Glass', description = 'It has a description!', args = {mat = 'glass'}},
    }
    lib.registerMenu({
        id = 'recycleMenu',
        title = 'Recycling Center',
        position = 'top-right',
        options = options
    }, function(selected, secondary, args)
        local mat = args.mat  -- Access the 'mat' property from the args table
        print(mat)

        if mat then
            TriggerServerEvent('vista-recycleCenter:RemoveVoucher', mat)
        else
            TriggerServerEvent('visa-recycleCenter:Stinky')
        end
    end)
end

-- Ped Creation
Citizen.CreateThread(function()
    dprint('Spawning ped...')
    
    RequestModel(Config.pedModel)
    while not HasModelLoaded(GetHashKey(Config.pedModel)) do
        Citizen.Wait(0)
    end
    dprint('Ped model loaded')
    
    local ped = CreatePed(1, GetHashKey(Config.pedModel), Config.pedCoords.x, Config.pedCoords.y, Config.pedCoords.z, 0.0, true, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetEntityInvincible(ped, true)
    SetEntityCoordsNoOffset(ped, Config.pedCoords.x, Config.pedCoords.y, Config.pedCoords.z, true, true, true)
   --SetEntityHeading(ped, heading)


    
    dprint('Ped spawned')
    local pedNetID = NetworkGetNetworkIdFromEntity(ped)
    exports.ox_target:addEntity( pedNetID, {
        name = "Recycle Man",
        radius = 3.0, 
        label = "Interact",
        icon = 'fa-solid fa-male',
        event = "vista-recycleCenter:openMenu" 
})
    
    dprint('Target data added')
end)






-- Misc
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    print('The resource ' .. resourceName .. ' has been started.')
    createMenu()
    if Config.debug then
        print("Debug Mode is enabled")
    end
  end)

