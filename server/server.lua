local QBCore = exports['qb-core']:GetCoreObject()
local inventory = exports.ox_inventory
local playername = NetworkPlayerGetName(source)

local whitelistedMaterials = {
    "iron",
    "copper",
    "plastic",
    "aluminium",
    "metalscrap",
    "steel",
    "rubber",
    "brass",
    "glass"

}


-- Net Events

RegisterNetEvent('vista-recycleCenter:GiveVoucher', function(jobCompleted)
    if jobCompleted then
        inventory:Additem(source, Config.voucherItem, 1)
    else
        DropPlayer(source, 'You should really get better at this...')
        print('Dropped Player'.. playername .. 'for trying to abuse a function')
    end

end)


RegisterNetEvent('vista-recycleCenter:RemoveVoucher', function(material)
    local isMaterialWhitelisted = false
    for _, allowedMaterial in ipairs(whitelistedMaterials) do
        if allowedMaterial == material then
            isMaterialWhitelisted = true
            break
        end
    end
    if isMaterialWhitelisted then
        if inventory.Search(source, 'count', Config.voucherItem) then
            if inventory:RemoveItem(source, Config.voucherItem, 1) then
                inventory:Additem(source, material, Config.matAmount)
                QBCore.Functions.Notify(source, 'You Traded in your' .. Config.voucherItem.. 'for' ..'x'..Config.matAmount .. material)
            else
                DropPlayer(source, "You smell bad")
                print('Dropped Player'.. playername .. 'for trying to abuse a function')
            end
        else
            QBCore.Functions.Notify(source, "You need a voucher!", "alert")
            print('Dropped Player'.. playername .. 'for trying to abuse a function')
        end
    else
        DropPlayer(source, "You ain't got enough args playa")
    end
end)

RegisterNetEvent('vista-recycleCenter:Stinky', function()
    DropPlayer(source, 'you stink')
    print('Dropped Player'.. playername .. 'for trying to abuse a function')
end)





