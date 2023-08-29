local QBCore = exports['qb-core']:GetCoreObject()
local inventory = exports.ox_inventory


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

RegisterNetEvent('vista-recycleCenter:GiveVoucher', function()
    inventory:Additem(source, 'recycleVoucher')
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
        if inventory.HasItem(source, 'recycleVoucher', 1) then
            if inventory:RemoveItem(source, 'recycleVoucher') then
                inventory:Additem(source, material)
            else
                DropPlayer(source, "You smell bad")
            end
        else
            Qbcore.Functions.Notify(source, "You need a voucher!", "alert")
        end
    else
        DropPlayer(source, "You ain't got enough args playa")
    end
end)





