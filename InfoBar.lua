local KillIconData = http.Get( "https://i.imgur.com/5oghBBk.png" );
local imgRGBA, imgWidth, imgHeight = common.DecodePNG( KillIconData );
local KillIconTexture = draw.CreateTexture( imgRGBA, imgWidth, imgHeight );

local DefaultFont = draw.CreateFont( "Impact", 18 )
local NumberFont = draw.CreateFont( "Impact", 17 )

callbacks.Register( 'Draw', function()

	InfoBarHelper();
	local w, h = draw.GetScreenSize();

	if not entities.GetLocalPlayer() then
		return
	end

	if TeamIndex == 0 or TeamIndex == 1 then
		return
	end

	-- Base Background
	draw.Color( 11, 29, 58, 180 )
	draw.RoundedRectFill( w/2.5, h-30, w-(w/2.5), h )

	-- Kills
	draw.Color( TeamBasedCLR[1], TeamBasedCLR[2], TeamBasedCLR[3], TeamBasedCLR[4] )
	draw.SetFont( DefaultFont )	draw.Text( (w/2.5) + 15, h-30, "K" )
	draw.Color( 255, 255, 255, 255 )
	draw.SetFont( NumberFont )	draw.Text( KillsTextWidth, h-16, Kills )
	if Kills <= 9 then 						KillsTextWidth = (w/2.5) + 15
	elseif Kills > 9 and Kills <= 99 then 	KillsTextWidth = (w/2.5) + 13
	elseif Kills > 99 and Kills <= 999 then KillsTextWidth = (w/2.5) + 10
	elseif Kills > 999 then					KillsTextWidth = (w/2.5) + 7
	end

	-- Assists
	draw.Color( TeamBasedCLR[1], TeamBasedCLR[2], TeamBasedCLR[3], TeamBasedCLR[4] )
	draw.SetFont( DefaultFont )	draw.Text( (w/2.5) + 35, h-30, "A" )
	draw.Color( 255, 255, 255, 255 )
	draw.SetFont( NumberFont )	draw.Text( AssistsTextWidth, h-16, Assists )
	if Assists <= 9 then 						AssistsTextWidth = (w/2.5) + 35
	elseif Assists > 9 and Assists <= 99 then	AssistsTextWidth = (w/2.5) + 33
	elseif Assists > 99 then 					AssistsTextWidth = (w/2.5) + 30
	end

	-- Deaths
	draw.Color( TeamBasedCLR[1], TeamBasedCLR[2], TeamBasedCLR[3], TeamBasedCLR[4] )
	draw.SetFont( DefaultFont )	draw.Text( (w/2.5) + 55, h-30, "D" )
	draw.Color( 255, 255, 255, 255 )
	draw.SetFont( NumberFont )	draw.Text( DeathsTextWidth, h-16, Deaths )
	if Deaths <= 9 then 					DeathsTextWidth = (w/2.5) + 55
	elseif Deaths > 9 and Deaths <= 99 then DeathsTextWidth = (w/2.5) + 53
	elseif Deaths > 99 then 				DeathsTextWidth = (w/2.5) + 50
	end

	-- Round Kills
	if RoundKills > 0 then
	draw.SetTexture( KillIconTexture )
	draw.FilledRect( (((w/2.5)+55)+10), (h-30)+6, (((w/2.5)+55)+10)+imgWidth, h )
	draw.Color( TeamBasedCLR[1], TeamBasedCLR[2], TeamBasedCLR[3], TeamBasedCLR[4] )
	draw.SetFont( NumberFont )	draw.Text( (((w/2.5)+55)+8)+imgWidth, h-22, RoundKills )
	end

	-- Velocity
	draw.Color( TeamBasedCLR[1], TeamBasedCLR[2], TeamBasedCLR[3], TeamBasedCLR[4] )
	draw.SetFont( DefaultFont )	draw.Text( (w-(w/2.5)-100), h-30, "VEL" )
	draw.Color( 255, 255, 255, 255 )
	draw.SetFont( NumberFont )	draw.Text( VelTextWidth, h-16, Velocity )
	if Velocity <= 9 then						VelTextWidth = (w-(w/2.5)-95)
	elseif Velocity > 9 and Velocity <= 99 then	VelTextWidth = (w-(w/2.5)-98)
	elseif Velocity > 99 then					VelTextWidth = (w-(w/2.5)-101)
	end

	-- Ping
	draw.Color( TeamBasedCLR[1], TeamBasedCLR[2], TeamBasedCLR[3], TeamBasedCLR[4] )
	draw.SetFont( DefaultFont )	draw.Text( (w-(w/2.5)-74), h-30, "PING" )
	draw.Color( 255, 255, 255, 255 )
	draw.SetFont( NumberFont )	draw.Text( PingTextWidth, h-16, Ping )
	if Ping <= 9 then					PingTextWidth = (w-(w/2.5)-64)
	elseif Ping > 9 and Ping <= 99 then	PingTextWidth = (w-(w/2.5)-68)
	elseif Ping > 99 then				PingTextWidth = (w-(w/2.5)-70)
	end

	-- FPS
	draw.Color( TeamBasedCLR[1], TeamBasedCLR[2], TeamBasedCLR[3], TeamBasedCLR[4] )
	draw.SetFont( DefaultFont )	draw.Text( (w-(w/2.5)-36), h-30, "FPS" )
	draw.Color( 255, 255, 255, 255 )
	draw.SetFont( NumberFont )	draw.Text( FPSTextWidth, h-16, FPS )
	if FPS <= 99 then	FPSTextWidth = (w-(w/2.5)-33)
	else 				FPSTextWidth = (w-(w/2.5)-36)
	end

end )

local GetFPS = 0.0
function InfoBarHelper()

	GetFPS = 0.9 * GetFPS + (1.0 - 0.9) * globals.AbsoluteFrameTime();
	FPS =  math.floor((1.0 / GetFPS) + 0.5);

	if not entities.GetLocalPlayer() then
		return
	end

	local Entity = entities.GetLocalPlayer();
	local Alive = Entity:IsAlive();

	-- Team
	TeamIndex = entities.GetLocalPlayer():GetProp( 'm_iTeamNum' );
	if TeamIndex == 2 then TeamBasedCLR = {255, 140, 0, 255}
	elseif TeamIndex == 3 then TeamBasedCLR = {0, 128, 255, 255}
	end

	-- Kills, Assists, Deaths, Round Kills
	Kills = entities.GetPlayerResources():GetPropInt( 'm_iKills', client.GetLocalPlayerIndex() );
	Assists = entities.GetPlayerResources():GetPropInt( 'm_iAssists', client.GetLocalPlayerIndex() );
	Deaths = entities.GetPlayerResources():GetPropInt( 'm_iDeaths', client.GetLocalPlayerIndex() );
	RoundKills = Entity:GetProp( 'm_iNumRoundKills' );

	-- Velocity
	local VelocityX, VelocityY = Entity:GetPropFloat( "localdata", "m_vecVelocity[0]" ), Entity:GetPropFloat( "localdata", "m_vecVelocity[1]" )
	local InitialVelocity = math.sqrt( VelocityX^2 + VelocityY^2 );
	local FinalVelocity = math.min( 9999, InitialVelocity ) + 0.2;
	if Alive then
		Velocity = math.floor( FinalVelocity )
	else
		Velocity = 0
	end

	-- Ping
	Ping = entities.GetPlayerResources():GetPropInt( "m_iPing", client.GetLocalPlayerIndex() );
end
