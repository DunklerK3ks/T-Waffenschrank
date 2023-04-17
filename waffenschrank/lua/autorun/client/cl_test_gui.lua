net.Receive("OpenTestGui", function()
    local title = "Waffenschrank made by Tim.#6967"
    local madeBy = net.ReadString() or "Unknown"

    print("Received OpenTestGui message with madeBy =", madeBy)

    local frame = vgui.Create("DFrame")
    frame:SetSize(600, 400)
    frame:SetTitle(title)
    frame:SetVisible(true)
    frame:SetDraggable(false)
    frame:ShowCloseButton(true)
    frame:Center()
    frame:MakePopup()
    frame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50, 200))
    end

    local label = vgui.Create("DLabel", frame)
    label:SetPos(10, 40)
    label:SetSize(280, 40)
    label:SetText("Waffenschrank")
    label:SetFont("DermaLarge")
    label:SetContentAlignment(5)

    local jobWeapons = {
        [TEAM_KADETT] = {
            {"rw_sw_nade_training", "T-Granate"},
        },
        [TEAM_501STAVPPVT] = {
            {"weapon_smg1", "SMG"},
            {"rw_sw_dc15a", "DC-15s"},
            {"rw_sw_dc15s", "DC-15s"}

        },
        [TEAM_501STPVTTC] = {
            {"rw_sw_dc15s", "DC-15s"},
        },
    }

    local jobName = LocalPlayer():Team() or TEAM_CITIZEN
    print("jobName =", jobName)
    if jobWeapons[jobName] == nil then
        print("No weapons for jobName =", jobName)
        return
    end

    for i, weaponData in pairs(jobWeapons[jobName]) do
        local weapon = weaponData[1]
        local weaponTitle = weaponData[2]

        local button = vgui.Create("DButton", frame)
        button:SetPos(10 + (i-1)*140, 80)
        button:SetText("")
        button:SetSize(120, 50)
        button.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 100, 128))
            draw.SimpleText(weaponTitle, "DermaLarge", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        button.DoClick = function()
            net.Start("GetWeaponFromWaffenschrank")
            net.WriteString(weapon)
            net.SendToServer()
        end
    end
end)
