--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

Clockwork.kernel:IncludePrefixed("cl_schema.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_theme.lua");
Clockwork.kernel:IncludePrefixed("sh_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_schema.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

-- A function to check if a string is a Reich rank.
function Schema:IsStringReichRank(text, rank)
	if (type(rank) == "table") then
		for k, v in ipairs(rank) do
			if (self:IsStringReichRank(text, v)) then
				return true;
			end;
		end;
	elseif (rank == "STA") then
		if (string.find(text, "%pFUH%p") or string.find(text, "%pKOM%p")
		or string.find(text, "%pSTA%p")) then
			return true;
		end;
	else
		return string.find(text, "%p"..rank.."%p");
	end;
end;

-- A function to check if a player is a Reich rank.
function Schema:IsPlayerReichRank(player, rank, realRank)
	local name = player:Name();
	local faction = player:GetFaction();
	
	if (self:IsReichFaction(faction)) then
		if (type(rank) == "table") then
			for k, v in ipairs(rank) do
				if (self:IsPlayerReichRank(player, v, realRank)) then
					return true;
				end;
			end;
		elseif (rank == "STA" and !realRank) then
			if (string.find(name, "%pFuhrer%p") or string.find(name, "%pKommandant%p")
			or string.find(name, "%pStandarten%p")) then
				return true;
			end;
		else
			return string.find(name, "%p"..rank.."%p");
		end;
	end;
end;

-- A function to get a player's Reich rank.
function Schema:GetPlayerReichRank(player)
	local faction = player:GetFaction();
	
	if (faction == FACTION_REICH or faction == FACTION_GOV) then
		if (self:IsPlayerReichRank(player, "RCT")) then
			return 0;
		elseif (self:IsPlayerReichRank(player, "PVT")) then
			return 1;
		else
			return 2;
		end;
	elseif (self:IsPlayerReichRank(player, "SCH")) then
		return 0;
	elseif (self:IsPlayerReichRank(player, "OBE")) then
		return 1;
	elseif (self:IsPlayerReichRank(player, "STU")) then
		return 2;
	elseif (self:IsPlayerReichRank(player, "STA")) then
		return 3;
	elseif (self:IsPlayerReichRank(player, "KOM")) then
		return 4;
	elseif (self:IsPlayerReichRank(player, "FUH")) then
		return 6;
	end;
else
	return 5;
end;

-- A function to get if a faction is Reich.
function Schema:IsReichFaction(faction)
	return (faction == FACTION_REICH or faction == FACTION_GOV);
end;
