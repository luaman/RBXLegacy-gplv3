rbxversion = version();
print("ROBLOX Client version '" .. rbxversion .. "' loaded.");
settings().Rendering.frameRateManager = 2;
settings().Rendering.graphicsMode = 2;
settings().Network.MaxSendBuffer = 1000000;
settings().Network.PhysicsReplicationUpdateRate = 1000000;
settings().Network.SendRate = 1000000;

HeadColor=BrickColor.DarkGray();
TorsoColor=BrickColor.DarkGray();
LArmColor=BrickColor.DarkGray();
LLegColor=BrickColor.DarkGray();
RArmColor=BrickColor.DarkGray();
RLegColor=BrickColor.DarkGray();
--localized hats.
Hat1 = "rbxasset://charcustom/hats/fedora.rbxm"
Hat2 = "rbxasset://charcustom/hats/fedora.rbxm"
Hat3 = "rbxasset://charcustom/hats/fedora.rbxm"

function PlayerColorize()
	PlayerColorPattern = math.random(5);
	if (PlayerColorPattern==1) then
		HeadColor=BrickColor.random();
		TorsoColor=BrickColor.random();
		LArmColor=BrickColor.random();
		LLegColor=BrickColor.random();
		RArmColor=BrickColor.random();
		RLegColor=BrickColor.random();
	elseif (PlayerColorPattern==2) then
		local pantsColor=BrickColor.random();
		local shirtColor=BrickColor.random();
		local armsColor=BrickColor.random();
		HeadColor=BrickColor.random();
		TorsoColor=shirtColor;
		LArmColor=armsColor;
		LLegColor=pantsColor;
		RArmColor=armsColor;
		RLegColor=pantsColor;
	elseif (PlayerColorPattern==3) then
		local pantsColor=BrickColor.random();
		local shirtColor=BrickColor.random();
		HeadColor=BrickColor.random();
		TorsoColor=shirtColor;
		LArmColor=shirtColor;
		LLegColor=pantsColor;
		RArmColor=shirtColor;
		RLegColor=pantsColor;
	elseif (PlayerColorPattern==4) then
		local pantsColor=BrickColor.random();
		local shirtColor=BrickColor.random();
		local fleshColor=BrickColor.random();
		HeadColor=fleshColor;
		TorsoColor=shirtColor;
		LArmColor=fleshColor;
		LLegColor=pantsColor;
		RArmColor=fleshColor;
		RLegColor=pantsColor;
	elseif (PlayerColorPattern==5) then
		HeadColor=BrickColor.random();
		TorsoColor=BrickColor.random();
		LArmColor=BrickColor.Black();
		LLegColor=BrickColor.Black();
		RArmColor=BrickColor.Black();
		RLegColor=BrickColor.Black();
	end
end

function PlayerNoobify()
	PlayerColorPattern = math.random(3);
	if (PlayerColorPattern==1) then
		HeadColor=BrickColor.Yellow();
		TorsoColor=BrickColor.Blue();
		LArmColor=BrickColor.Yellow();
		LLegColor=BrickColor.new("Br. yellowish green");
		RArmColor=BrickColor.Yellow();
		RLegColor=BrickColor.new("Br. yellowish green");
	elseif (PlayerColorPattern==2) then
		HeadColor=BrickColor.new("Cool yellow");
		TorsoColor=BrickColor.random();
		LArmColor=BrickColor.new("Cool yellow");
		LLegColor=BrickColor.new("Pastel Blue");
		RArmColor=BrickColor.new("Cool yellow");
		RLegColor=BrickColor.new("Pastel Blue");
	elseif (PlayerColorPattern==3) then
		HeadColor=BrickColor.White();
		TorsoColor=BrickColor.random();
		LArmColor=BrickColor.White();
		LLegColor=BrickColor.new("Medium blue");
		RArmColor=BrickColor.White();
		RLegColor=BrickColor.new("Medium blue");
	end
end

function CSServer(Port,BodyColors)
	Server = game:GetService("NetworkServer")
	RunService = game:GetService("RunService")
	Server:start(Port, 20)
	RunService:run();
	game:GetService("Players").PlayerAdded:connect(function(Player)
		print("Player '" .. Player.Name .. "' with ID '" .. Player.userId .. "' added");
		Player:LoadCharacter();
		if (BodyColors == true) then
			PlayerColorize();
		else
			PlayerNoobify();
		end
		Player.Character['Head'].BrickColor = HeadColor;
		Player.Character['Torso'].BrickColor = TorsoColor;
		Player.Character['Left Arm'].BrickColor = LArmColor;
		Player.Character['Left Leg'].BrickColor = LLegColor;
		Player.Character['Right Arm'].BrickColor = RArmColor;
		Player.Character['Right Leg'].BrickColor = RLegColor;
		while true do 
			wait(0.001)
			if (Player.Character ~= nil) then
				if (Player.Character.Humanoid.Health == 0) then
					wait(5)
					Player:LoadCharacter()
					if (BodyColors == true) then
						PlayerColorize();
					else
						PlayerNoobify();
					end
					Player.Character['Head'].BrickColor = HeadColor;
					Player.Character['Torso'].BrickColor = TorsoColor;
					Player.Character['Left Arm'].BrickColor = LArmColor;
					Player.Character['Left Leg'].BrickColor = LLegColor;
					Player.Character['Right Arm'].BrickColor = RArmColor;
					Player.Character['Right Leg'].BrickColor = RLegColor;
				elseif (Player.Character.Parent == nil) then 
					wait(5)
					Player:LoadCharacter() -- to make sure nobody is deleted.
					if (BodyColors == true) then
						PlayerColorize();
					else
						PlayerNoobify();
					end
					Player.Character['Head'].BrickColor = HeadColor;
					Player.Character['Torso'].BrickColor = TorsoColor;
					Player.Character['Left Arm'].BrickColor = LArmColor;
					Player.Character['Left Leg'].BrickColor = LLegColor;
					Player.Character['Right Arm'].BrickColor = RArmColor;
					Player.Character['Right Leg'].BrickColor = RLegColor;
				end
			end
		end
	end)
	game:GetService("Players").PlayerRemoving:connect(function(Player)
		print("Player '" .. Player.Name .. "' with ID '" .. Player.userId .. "' leaving")	
	end)
	game:GetService("RunService"):Run();
	pcall(function() game.Close:connect(function() Server:Stop(); end) end);
	Server.IncommingConnection:connect(IncommingConnection);
end

function CSConnect(UserID,ServerIP,ServerPort,PlayerName,OutfitID,ColorHash,PantsID,ShirtID,TShirtID,Hat1ID,Hat2ID,Hat3ID,Hat1Version,Hat2Version,Hat3Version,Ticket)
	pcall(function() game:SetPlaceID(-1, false) end);
	pcall(function() game:GetService("Players"):SetChatStyle(Enum.ChatStyle.ClassicAndBubble) end);
	
	pcall(function()
		game:GetService("GuiService").Changed:connect(function()
			pcall(function() game:GetService("GuiService").ShowLegacyPlayerList=true; end);
			pcall(function() game.CoreGui.RobloxGui.PlayerListScript:Remove(); end);
			pcall(function() game.CoreGui.RobloxGui.PlayerListTopRightFrame:Remove(); end);
			pcall(function() game.CoreGui.RobloxGui.BigPlayerListWindowImposter:Remove(); end);
			pcall(function() game.CoreGui.RobloxGui.BigPlayerlist:Remove(); end);
		end);
	end)
	
	local suc, err = pcall(function()
		client = game:GetService("NetworkClient")
		player = game:GetService("Players"):CreateLocalPlayer(UserID) 
		player:SetSuperSafeChat(false)
		pcall(function() player:SetUnder13(false) end);
		pcall(function() player:SetMembershipType(Enum.MembershipType.BuildersClub) end);
		pcall(function() player:SetAccountAge(365) end);
		if (OutfitID and OutfitID ~= 0) then
			player.CharacterAppearance="http://www.roblox.com/Asset/CharacterFetch.ashx?userId="..OutfitID;
		elseif (ColorHash and ColorHash ~= "") then
			local aid = "http://www.roblox.com/asset?id="
			local bcid = "http://assetgame.roblox.com/Asset/BodyColors.ashx?avatarHash="
			local charapp = bcid..ColorHash..";"..aid..PantsID..";"..aid..ShirtID..";"..aid..TShirtID..";"..aid..Hat1ID.."&version="..Hat1Version..";"..aid..Hat2ID.."&version="..Hat2Version..";"..aid..Hat3ID.."&version="..Hat3Version..";"
			player.CharacterAppearance = charapp
		else
			player.CharacterAppearance=0;
		end
		pcall(function() player.Name=PlayerName or ""; end);
		game:GetService("Visit")
	end)
	
	local function dieerror(errmsg)
		game:SetMessage(errmsg)
		wait(math.huge)
	end

	if not suc then
		dieerror(err)
	end

	local function disconnect(peer,lostconnection)
		game:SetMessage("You have lost connection to the game")
	end
	
	local function connected(url, replicator)
		replicator.Disconnection:connect(disconnect)
		local marker = nil
		local suc, err = pcall(function()
			game:SetMessageBrickCount()
			marker = replicator:SendMarker()
		end)
		if not suc then
			dieerror(err)
		end
		marker.Received:connect(function()
			local suc, err = pcall(function()
				game:ClearMessage()
			end)
			if not suc then
				dieerror(err)
			end
		end)
	end

	local function rejected()
		dieerror("Failed to connect to the Game. (Connection rejected)")
	end

	local function failed(peer, errcode, why)
		dieerror("Failed to connect to the Game. (ID="..errcode.." ["..why.."])")
	end

	local suc, err = pcall(function()
		game:SetMessage("Connecting to server...");
		client.ConnectionAccepted:connect(connected)
		client.ConnectionRejected:connect(rejected)
		client.ConnectionFailed:connect(failed)
		client:Connect(ServerIP,ServerPort, 0, 20)
	end)

	if not suc then
		local x = Instance.new("Message")
		x.Text = err
		x.Parent = workspace
		wait(math.huge)
	end
end

--same function but with our new localized customization system!
function CSConnect2(UserID,ServerIP,ServerPort,PlayerName,OutfitID,Hat1ID,Hat2ID,Hat3ID,Ticket)
	pcall(function() game:SetPlaceID(-1, false) end);
	pcall(function() game:GetService("Players"):SetChatStyle(Enum.ChatStyle.ClassicAndBubble) end);
	
	pcall(function()
		game:GetService("GuiService").Changed:connect(function()
			pcall(function() game:GetService("GuiService").ShowLegacyPlayerList=true; end);
			pcall(function() game.CoreGui.RobloxGui.PlayerListScript:Remove(); end);
			pcall(function() game.CoreGui.RobloxGui.PlayerListTopRightFrame:Remove(); end);
			pcall(function() game.CoreGui.RobloxGui.BigPlayerListWindowImposter:Remove(); end);
			pcall(function() game.CoreGui.RobloxGui.BigPlayerlist:Remove(); end);
		end);
	end)
	
	local suc, err = pcall(function()
		client = game:GetService("NetworkClient")
		player = game:GetService("Players"):CreateLocalPlayer(UserID) 
		player:SetSuperSafeChat(false)
		pcall(function() player:SetUnder13(false) end);
		pcall(function() player:SetMembershipType(Enum.MembershipType.BuildersClub) end);
		pcall(function() player:SetAccountAge(365) end);
		if (OutfitID and OutfitID ~= 0) then
			player.CharacterAppearance="http://www.roblox.com/Asset/CharacterFetch.ashx?userId="..OutfitID;
		elseif (Hat1ID and Hat1ID ~= 0) then
			Hat1 = "rbxasset://charcustom/hats/"..Hat1ID
			Hat2 = "rbxasset://charcustom/hats/"..Hat2ID
			Hat3 = "rbxasset://charcustom/hats/"..Hat3ID
			local charapp = "rbxasset://charcustom/CharacterColors.rbxm;"..Hat1..";"..Hat2..";"..Hat3
			player.CharacterAppearance = charapp
		else
			player.CharacterAppearance=0;
		end
		pcall(function() player.Name=PlayerName or ""; end);
		game:GetService("Visit")
	end)
	
	local function dieerror(errmsg)
		game:SetMessage(errmsg)
		wait(math.huge)
	end

	if not suc then
		dieerror(err)
	end

	local function disconnect(peer,lostconnection)
		game:SetMessage("You have lost connection to the game")
	end
	
	local function connected(url, replicator)
		replicator.Disconnection:connect(disconnect)
		local marker = nil
		local suc, err = pcall(function()
			game:SetMessageBrickCount()
			marker = replicator:SendMarker()
		end)
		if not suc then
			dieerror(err)
		end
		marker.Received:connect(function()
			local suc, err = pcall(function()
				game:ClearMessage()
			end)
			if not suc then
				dieerror(err)
			end
		end)
	end

	local function rejected()
		dieerror("Failed to connect to the Game. (Connection rejected)")
	end

	local function failed(peer, errcode, why)
		dieerror("Failed to connect to the Game. (ID="..errcode.." ["..why.."])")
	end

	local suc, err = pcall(function()
		game:SetMessage("Connecting to server...");
		client.ConnectionAccepted:connect(connected)
		client.ConnectionRejected:connect(rejected)
		client.ConnectionFailed:connect(failed)
		client:Connect(ServerIP,ServerPort, 0, 20)
	end)

	if not suc then
		local x = Instance.new("Message")
		x.Text = err
		x.Parent = workspace
		wait(math.huge)
	end
end

_G.CSServer=CSServer;
_G.CSConnect=CSConnect;
_G.CSConnect2=CSConnect2;
