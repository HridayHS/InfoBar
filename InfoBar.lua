local function Velocity()
    if entities.GetLocalPlayer() ~= nil then
        local Entity = entities.GetLocalPlayer();
        local Alive = Entity:IsAlive();

        local VelocityX = Entity:GetPropFloat( "localdata", "m_vecVelocity[0]" );
        local VelocityY = Entity:GetPropFloat( "localdata", "m_vecVelocity[1]" );
   
        local Velocity = math.sqrt( VelocityX^2 + VelocityY^2 );
        local FinalVelocity = math.min( 9999, Velocity ) + 0.2;

		if Alive then
			return math.floor( FinalVelocity )
		else
			return 0
		end
	end
end

local function Ping()
	if entities.GetLocalPlayer() ~= nil then
		local LocalPlayerPing = entities.GetPlayerResources():GetPropInt( "m_iPing", client.GetLocalPlayerIndex() );
		return LocalPlayerPing
	end
end

local GetFPS = 0.0
local function FPS()

		GetFPS = 0.9 * GetFPS + (1.0 - 0.9) * globals.AbsoluteFrameTime();
		return math.floor((1.0 / GetFPS) + 0.5);

end

local DefaultFont = draw.CreateFont( "Impact", 18 )
local NumberFont = draw.CreateFont( "Impact", 17 )

callbacks.Register( 'Draw', function()

if entities.GetLocalPlayer() then

	local w, h = draw.GetScreenSize();
		
	local Kills = entities.GetPlayerResources():GetPropInt( 'm_iKills', client.GetLocalPlayerIndex() );
	local Deaths = entities.GetPlayerResources():GetPropInt( 'm_iDeaths', client.GetLocalPlayerIndex() );

	draw.Color( 0, 128, 255, 150 )	draw.RoundedRectFill( w/2.5, h-30, w-(w/2.5), h )

	-- Kills
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( DefaultFont )	draw.Text( (w/2.5) + 20, h-30, "K" )
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w/2.5) + 20, h-16, Kills )
	-- Deaths
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( DefaultFont )	draw.Text( (w/2.5) + 40, h-30, "D" )
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w/2.5) + 40, h-16, Deaths )

	-- Velocity
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( DefaultFont )	draw.Text( (w/2.5) + 96, h-30, "VEL" )
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w/2.5) + 96, h-16, Velocity() )
	-- Ping
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( DefaultFont )	draw.Text( (((w/2.5)+(w-(w/2.5)))/2)+24, h-30, "PING" )
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (((w/2.5)+(w-(w/2.5)))/2)+24, h-16, Ping() )
	-- FPS
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( DefaultFont )	draw.Text( (w-(w/2.5)- 43), h-30, "FPS" )
	draw.Color( 255, 255, 255, 255 )	draw.SetFont( NumberFont )	draw.Text( (w-(w/2.5)- 43), h-16, FPS() )
	
end

end )
