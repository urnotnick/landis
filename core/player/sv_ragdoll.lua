util.AddNetworkString("ragdoll_camera")

function GM:PlayerSpawn(ply)
	ply:SetModel("models/player/Group01/male_06.mdl")
end

hook.Add("DoPlayerDeath", "ragdoll_create",function(ply)
	ply:CreateRagdoll()
end)

hook.Add( "PhysgunPickup", "pickupPlayer", function( ply, ent )
	if ( ply:IsAdmin() and ent:IsPlayer() ) then
		ent:SetMoveType(MOVETYPE_NONE)
		//ent:Freeze( true )
		return true
	end
end )
hook.Add("PhysgunDrop", "dropPlayer", function(ply, ent)
	if ent:IsPlayer() then
		//ent:Freeze(false)
		ent:SetMoveType(MOVETYPE_WALK)
	end
end)