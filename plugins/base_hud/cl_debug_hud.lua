local VERSION = landis.__VERSION or "DEV-BUILD"
local DISPLAY = landis.__DISPLAY or "LandisBase"
local XTNOTES = landis.__XTNOTES or [[]]
local DVBUILD = landis.__DVBUILD or false

surface.CreateFont("DebugHUD24", {
	font = "Segoe UI Bold",
	antialias = true,
	extended = true,
	weight = 2000,
	size = 24
})
surface.CreateFont("DebugHUD18", {
	font = "Segoe UI Light",
	antialias = true,
	extended = true,
	weight = 2000,
	size = 18
})
landis.DefineSetting("debugHUD",{type="tickbox",value=false,default=false,category="UI",name="Debug Hud"})
local function GetDebugHUDText()
	local t = "[Debug Info]\n"
	
	t=t.."usergroup: " .. LocalPlayer():GetUserGroup() .. "\n"
	t=t.."schema: " .. landis.Schema.Name .. "\n" -- deathTime
	t=t.."ping: " .. LocalPlayer():Ping() .. "\n"
	t=t.."isTyping: " .. tostring(LocalPlayer():IsTyping()) .. "\n"
	t=t.."radialMenuOpen: " .. tostring(not landis.Radial.Close) .. "\n"
	t=t.."radialMenuRadius: " .. landis.Radial.Radius .. "\n"
	t=t.."deathTime: " .. deathTime .. "\n"
	t=t.."teamIndex: " .. landis.TeamIndex .. "\n"
	t=t.."hunger: " .. LocalPlayer():GetHunger() .. "\n"
	t=t.."inventoryItemCount: " .. #(LocalPlayer().Inventory) .. "\n"
	t=t.."3d2dDoorsDrawCount: " .. debugDrawDoorCount .. "\n"
	return t
end

hook.Add("HUDPaint", "DebugHud_LANDIS", function()
	if not DVBUILD then return end
	local scrW = ScrW()
	local scrH = ScrH()
	local drwH = scrH/2+(scrH/4)
	local msg = LocalPlayer():SteamID64() .. "\n" .. os.date("%X - %m/%d/%Y", os.time())
	draw.SimpleText("Landis Alpha 0.4","DebugHUD24",scrW/2,drwH,Color(200,200,200,140),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	draw.DrawText(msg,"DebugHUD18",scrW/2,drwH+9,Color(200,200,200,140),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	if landis.GetSetting("debugHUD") then
		draw.DrawText(GetDebugHUDText(), "BudgetLabel", 16, 16)
	end
end)

concommand.Add("landis_debug_dump", function()
	print("=====[DEBUG TABLE DUMP]=====")
	PrintTable(landis)
	print("=====[END DUMP]=====")
end)
