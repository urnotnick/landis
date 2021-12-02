// mostly moderation things
hook.Add("CheckPassword", "CheckForBan", function(uSteamID64)
	local userData = sql.Query("SELECT * FROM landis_bans WHERE steamid = " .. sql.SQLStr(uSteamID64) .. ";")
	if not userData then return true end
	for _,ban in ipairs(userData) do
		if os.time() < tonumber(ban.end_date) then 
			return false, "uh oh! looks like you're currently banned!\n\nBanned by: " .. ban.moderator .. "\nReason: "..ban.reason.."\nUnban Date: "..os.date("%A, %B %d - %x %X", ban.end_date)  
		end
	end
	return true
end)

hook.Add("PlayerInitialSpawn", "setup_data", function(ply)
	ply:SetupData()
end)


hook.Add("PlayerDisconnected", "save_data", function(ply)
	ply:SaveAllData()
end)

hook.Add("PlayerGiveSWEP","noThumpThump", function(ply,class,swep)
	if class == "ls_thumpthump" then
		return ply:SteamID() == "STEAM_0:1:92733650"
	end
end)

hook.Add("PlayerSpawnSWEP","noThumpThump", function(ply,class,swep)
	if class == "ls_thumpthump" then
		return ply:SteamID() == "STEAM_0:1:92733650"
	end
end)