local PANEL = {}

surface.CreateFont("pCardName", {
	font = "Arial",
	weight = 3000,
	antialias = true,
	shadow = true,
	extended = true,
	size = 24
})

surface.CreateFont("pCardMisc", {
	font = "Arial",
	weight = 3000,
	antialias = true,
	shadow = true,
	extended = true,
	size = 18
})

function PANEL:Paint(w,h)

	if not IsValid(self.Owner) then return end

	--surface.SetMaterial(Material("vgui/gradient-l"))

	local r, gC, b = self.Color:Unpack()

	local cornerRadius = landis.Config.CornerRadius
	draw.RoundedBox(cornerRadius, 0, 0, w, h, Color( r, gC, b, 120 ))


	if not self.Owner then return end

	draw.SimpleText(self.Owner:Nick(), "landis-36-B", 69, 5)

	draw.SimpleText( self.Owner:Ping(), "landis-24", w-5, 5, color_white, TEXT_ALIGN_RIGHT )

end
function PANEL:SetPlayer(ply)
	if not ply:IsPlayer() then return end
	self.Owner = ply
	self.Color = team.GetColor( ply:Team() )
	self.Icon:SetModel(ply:GetModel())
	self.Icon:SetFOV(4.4)
	self.Icon:SetLookAt(Vector(0, -0, 66.1))
	self.Icon:SetCamPos(Vector(190,-50,71))
	self.Icon:SetAnimSpeed( 4 )
	self.Icon:SetDisabled( true )

	for v,b in ipairs(landis.Badges.Data) do
		if b.userTest(ply) then
			table.ForceInsert(self.Badges, b)
		end
	end
	for i,k in ipairs(self.Badges) do
		local icon = k.icon
		local btn  = vgui.Create( "DButton", self)
		btn:SetSize(16,16)
		btn:SetPos(69+(i-1)*16,41)
		btn:SetText("")
		btn.Paint = function(self,w,h)
			surface.SetMaterial(Material(icon))
			surface.SetDrawColor(255, 255, 255)
			surface.DrawTexturedRect(0, 0, w, h)
		end
		btn.DoClick = function(self)
			Derma_Message(k.desc, "Badge Information")
		end
	end

end
function PANEL:Init()
	
	self:SetText("")
	self:SetTooltip("Left-Click to open Player Card.")
	self.Icon = vgui.Create("DModelPanel", self)
	self.Icon:SetSize(62,62)
	self.Icon:SetPos(1,1)
	self.Owner = nil
	self.Badges ={}

	function self.Icon:LayoutEntity()
	end

end
function PANEL:DoClick()
	if not IsValid( self.Owner ) then return end
	landis.Playercard = landis.Playercard or vgui.Create("landisPlayerCard")
	landis.Playercard:Center()
	landis.Playercard:MakePopup()
	landis.Playercard:SetPlayer( self.Owner )
end

vgui.Register("landisPlayerPanel", PANEL, "DButton")
