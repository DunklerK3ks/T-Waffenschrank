util.AddNetworkString("OpenTestGui")
util.AddNetworkString("GetWeaponFromWaffenschrank")

net.Receive("GetWeaponFromWaffenschrank", function(len, ply)
    local weaponName = net.ReadString()

    if not IsValid(ply) then
        print("[ERROR] Player is invalid!")
        return
    end

    if not ply:Alive() then
        print("[ERROR] Player is dead!")
        return
    end

    local weapon = ply:Give(weaponName)

    if not IsValid(weapon) then
        print("[ERROR] Failed to give weapon '" .. weaponName .. "' to player " .. ply:Nick() .. " (" .. ply:SteamID() .. ")!")
        return
    end

    print("[SUCCESS] Player " .. ply:Nick() .. " (" .. ply:SteamID() .. ") has been given weapon '" .. weapon:GetClass() .. "'.")

    ply:SelectWeapon(weapon:GetClass())
end)

hook.Add("PlayerSay", "OpenTestGuiChatCommand", function(ply, text)
    if text == "/waffenschrank" then
        net.Start("OpenTestGui")
        net.Send(ply)
        return ""
    end
end)
