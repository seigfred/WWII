--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

--[[ This is where you might add any functions for your schema. --]]
function Schema:MakeAnnouncement(text)
	for k, v in ipairs(player.GetAll()) do
		v:PrintChat(text);
	end;
end;