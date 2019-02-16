local DefaultFont = draw.CreateFont( "Impact", 18 )
local NumberFont = draw.CreateFont( "Impact", 17 )

callbacks.Register( 'Draw', function()

if entities.GetLocalPlayer() then

	draw.Color( 11, 29, 58, 100 )	draw.RoundedRectFill( w/2.5, h-30, w-(w/2.5), h )

	-- Kills
	draw.Color( 0, 128, 255, 255 )		draw.SetFont( DefaultFont )	draw.Text( (w/2.5) + 15, h-30, "K" )
	if Kills <= 9 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w/2.5) + 15, h-16, Kills )
	elseif Kills > 9 and Kills <= 99 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w/2.5) + 13, h-16, Kills )
	elseif Kills > 99 and Kills <= 999 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w/2.5) + 11, h-16, Kills )
	elseif Kills > 999 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w/2.5) + 6, h-16, Kills )
	end
	-- Assists
	draw.Color( 0, 128, 255, 255 )		draw.SetFont( DefaultFont )	draw.Text( (w/2.5) + 35, h-30, "A" )
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w/2.5) + 35, h-16, Assists )
	-- Deaths
	draw.Color( 0, 128, 255, 255 )		draw.SetFont( DefaultFont )	draw.Text( (w/2.5) + 55, h-30, "D" )
	if Deaths <= 9 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w/2.5) + 55, h-16, Deaths )
	elseif Deaths > 9 and Deaths <= 99 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w/2.5) + 53, h-16, Deaths )
	elseif Deaths > 99 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w/2.5) + 51, h-16, Deaths )
	end

	-- Velocity
	draw.Color( 0, 128, 255, 255 )		draw.SetFont( DefaultFont )	draw.Text( (w-(w/2.5)-100), h-30, "VEL" )
	if Velocity <= 9 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w-(w/2.5)-95), h-16, Velocity )
	elseif Velocity > 9 and Velocity <= 99 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w-(w/2.5)-98), h-16, Velocity )
	elseif Velocity > 99 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w-(w/2.5)-101), h-16, Velocity )
	end
	-- Ping
	draw.Color( 0, 128, 255, 255 )		draw.SetFont( DefaultFont )	draw.Text( (w-(w/2.5)-74), h-30, "PING" )
	if Ping <= 9 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w-(w/2.5)-65), h-16, Ping )
	elseif Ping > 9 and Ping <= 99 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w-(w/2.5)-68), h-16, Ping )
	elseif Ping > 99 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w-(w/2.5)-71), h-16, Ping )
	end
	-- FPS
	draw.Color( 0, 128, 255, 255 )		draw.SetFont( DefaultFont )	draw.Text( (w-(w/2.5)-36), h-30, "FPS" )
	if FPS() <= 99 then
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w-(w/2.5)-33), h-16, FPS() )
	else
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w-(w/2.5)-35.5), h-16, FPS() )
	end
	
end

end )

callbacks.Register( 'Draw', function()

 if entities.GetLocalPlayer() ~= nil then

	w, h = draw.GetScreenSize();

	local Entity = entities.GetLocalPlayer();
	local Alive = Entity:IsAlive();

	-- Kills, Assists, Deaths
	Kills = entities.GetPlayerResources():GetPropInt( 'm_iKills', client.GetLocalPlayerIndex() );
	Assists = entities.GetPlayerResources():GetPropInt( 'm_iAssists', client.GetLocalPlayerIndex() );
	Deaths = entities.GetPlayerResources():GetPropInt( 'm_iDeaths', client.GetLocalPlayerIndex() );

	-- My Name
	Name = client.GetPlayerNameByIndex( client.GetLocalPlayerIndex() );

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
end)

local GetFPS = 0.0
function FPS()
	GetFPS = 0.9 * GetFPS + (1.0 - 0.9) * globals.AbsoluteFrameTime();
	return math.floor((1.0 / GetFPS) + 0.5);
end
