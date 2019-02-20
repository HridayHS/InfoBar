local KillimgData = http.Get( "https://github.com/HridayHS/InfoBar/raw/master/images/Kill.png" );
local imgRGBA, imgWidth, imgHeight = common.DecodePNG( KillimgData );
local KillimgTexture = draw.CreateTexture( imgRGBA, imgWidth, imgHeight );

local DefaultFont = draw.CreateFont( "Impact", 18 )
local NumberFont = draw.CreateFont( "Impact", 17 )
local RoundKillFont = draw.CreateFont( "Impact", 15 )

callbacks.Register( 'Draw', function()
	InfoBarHelper()

	if not entities.GetLocalPlayer() then
		return
	end

	if TeamNumber == 0 or TeamNumber == 1 then
		return
	end

	-- Base Background
	draw.Color( 11, 29, 58, 180 ) draw.RoundedRectFill( x1, y1, x2, y2 )

	-- Kills, Assists, Deaths, Round Kills
	draw.Color( TeamBasedCLR[1], TeamBasedCLR[2], TeamBasedCLR[3], TeamBasedCLR[4] )
	draw.SetFont( DefaultFont )
	draw.Text( KWidth, y1, "K" )
	draw.Text( AWidth, y1, "A" )
	draw.Text( DWidth, y1, "D" )

	draw.Color( 255, 255, 255, 255 )
	draw.SetFont( NumberFont )	
	draw.Text( KillsWidth, CommonNumberH, Kills )
	draw.Text( AssistsWidth, CommonNumberH, Assists )
	draw.Text( DeathsWidth, CommonNumberH, Deaths )

	if RoundKills > 0 then
	draw.SetTexture( KillimgTexture )
	draw.Color( 255, 255, 255, 255 )
	draw.FilledRect( RoundKWidth, RoundKillimgH1, RoundKWidth+imgWidth, RoundKillimgH2 )

	draw.Color( TeamBasedCLR[1], TeamBasedCLR[2], TeamBasedCLR[3], TeamBasedCLR[4] )
	draw.SetFont( RoundKillFont )
	draw.Text( (RoundKWidth+imgWidth)-2, RoundKillsH, RoundKills )
	end

	-- Velocity, Ping, FPS
	draw.Color( TeamBasedCLR[1], TeamBasedCLR[2], TeamBasedCLR[3], TeamBasedCLR[4] )
	draw.SetFont( DefaultFont )
	draw.Text( VelTextWidth, y1, "VEL" )
	draw.Text( PingTextWidth, y1, "PING" )
	draw.Text( FPSTextWidth, y1, "FPS" )

	draw.Color( 255, 255, 255, 255 )
	draw.SetFont( NumberFont )
	draw.Text( VelWidth, CommonNumberH, Velocity )
	draw.Text( PingWidth, CommonNumberH, Ping )
	draw.Text( FPSWidth, CommonNumberH, FPS )

	if Kills <= -1 and Kills >= -9 then 		KillsWidth = KWidth-3
	elseif Kills <= -10 and Kills >= -99 then	KillsWidth = KWidth-6
	elseif Kills <= -100 and Kills >= -999 then	KillsWidth = KWidth-9
	elseif Kills <= 9 and Kills >= 0 then  		KillsWidth = KWidth
	elseif Kills > 9 and Kills <= 99 then 		KillsWidth = KWidth-2.5
	elseif Kills > 99 and Kills <= 999 then 	KillsWidth = KWidth-5
	elseif Kills > 999 then						KillsWidth = KWidth-8
	end
	if Assists <= 9 then 						AssistsWidth = AWidth
	elseif Assists > 9 and Assists <= 99 then	AssistsWidth = AWidth-2.5
	elseif Assists > 99 then 					AssistsWidth = AWidth-5
	end
	if Deaths <= 9 then 						DeathsWidth = DWidth
	elseif Deaths > 9 and Deaths <= 99 then 	DeathsWidth = DWidth-2.5
	elseif Deaths > 99 then 					DeathsWidth = DWidth-5
	end
	if Velocity <= 9 then						VelWidth = VelTextWidth+6
	elseif Velocity > 9 and Velocity <= 99 then	VelWidth = VelTextWidth+2
	elseif Velocity > 99 then					VelWidth = VelTextWidth-1
	end
	if Ping <= 9 then							PingWidth = PingTextWidth+10
	elseif Ping > 9 and Ping <= 99 then			PingWidth = PingTextWidth+6
	elseif Ping > 99 then						PingWidth = PingTextWidth+4
	end
	if FPS <= 99 then							FPSWidth = FPSTextWidth+3.5
	else 										FPSWidth = FPSTextWidth+1
	end
end )

local GetFPS = 0.0
function InfoBarHelper()
	w, h = draw.GetScreenSize();
	x1, y1, x2, y2 = w/2.5, h-30, w-x1, h

	CommonNumberH = y2-16
	KWidth, AWidth, DWidth, RoundKWidth = x1+15, x1+35, x1+55, x1+65
	RoundKillimgH1, RoundKillsH, RoundKillimgH2 = h-24, h-20, h
	VelTextWidth, PingTextWidth, FPSTextWidth = x2-100, x2-74, x2-36

	-- FPS
	GetFPS = 0.9 * GetFPS + (1.0 - 0.9) * globals.AbsoluteFrameTime();
	FPS =  math.floor((1.0 / GetFPS) + 0.5);

	if not entities.GetLocalPlayer() then
		return
	end

	local Entity = entities.GetLocalPlayer();

	-- Team
	TeamNumber = entities.GetLocalPlayer():GetTeamNumber()
	if TeamNumber == 2 then TeamBasedCLR = {255, 140, 0, 255}
	elseif TeamNumber == 3 then TeamBasedCLR = {0, 128, 255, 255}
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
	if Entity:IsAlive() then
		Velocity = math.floor( FinalVelocity )
	else
		Velocity = 0
	end

	-- Ping
	Ping = entities.GetPlayerResources():GetPropInt( "m_iPing", client.GetLocalPlayerIndex() );
end
