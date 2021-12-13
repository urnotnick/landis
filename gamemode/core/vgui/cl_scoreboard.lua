local PANEL = {}

openPlayercard = false

function PANEL:CreatePlayerList()

	local players = table.Copy( player.GetHumans() ) -- Bots tend to create errors when getting steam IDs and shit
	local sorted  = {}

	-- Sort the list by teams
	for i,t in ipairs(landis.Teams.Data) do
		for v,k in ipairs(team.GetPlayers(#landis.Teams.Data-i+1)) do
			table.ForceInsert(sorted, k)
		end
	end

	for v,k in ipairs(player.GetAll()) do
		local playerInfoCard = vgui.Create("landisPlayerPanel", nil, "landisPcard")
		
		self.Scroll:AddItem(playerInfoCard)
		playerInfoCard:Dock(TOP)
		playerInfoCard:SetSize(playerInfoCard:GetWide(),64)
		playerInfoCard:SetPlayer(k)
	end

end

function PANEL:Init()
	-- Make sure it can still run on low-res
	self:SetDraggable(false)
	self:ShowCloseButton(false)
	self:SetTitle("Scoreboard")
	
	self:DockPadding(7, 30, 7, 7)
	if ScrW() < 800 or ScrH() < 600 then
		self:SetSize(640,480)
		self:Center()
		self:MakePopup()
		self.Scroll = vgui.Create("DScrollPanel", self, "landis-baseScoreboardScrollPanel")
		self.Scroll.Paint = function(self,w,h) 
		end
		self.Scroll:Dock(FILL)
		self:CreatePlayerList()
	else
		self:SetSize(900,700)
		self:Center()
		self:MakePopup()
		self.Scroll = vgui.Create("DScrollPanel", self, "landis-baseScoreboardScrollPanel")
		self.Scroll.Paint = function(self,w,h) 
		end
		self.Scroll:Dock(FILL)
		self:CreatePlayerList()
	end
end

vgui.Register("landisScoreboard", PANEL, "DFrame")

local activePanel

-- Remove default scoreboard
function GM:ScoreboardShow()
	if not activePanel then
		activePanel = vgui.Create("landisScoreboard",nil,"landisScoreboardPlayer")
	end
end
function GM:ScoreboardHide()
	if activePanel then
		activePanel:Remove()
		activePanel = nil
	end
end
