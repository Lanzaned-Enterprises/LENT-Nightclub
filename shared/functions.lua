function EnterLocation()
    for k, v in pairs(Config.NightclubEntry) do 
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Wait(10)
        end
        SetEntityCoords(PlayerPedId(), v["InsideCoords"].x, v["InsideCoords"].y, v["InsideCoords"].z)
        DoScreenFadeIn(500)
    end
end

function ExitLocation()
    for k, v in pairs(Config.NightclubExit) do 
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Wait(10)
        end
        SetEntityCoords(PlayerPedId(), v["OutsideCoords"].x, v["OutsideCoords"].y, v["OutsideCoords"].z)
        DoScreenFadeIn(500)
    end
end

function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
	local scale = (1/dist)*20
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov   
	SetTextScale(scaleX*scale, scaleY*scale)
	SetTextFont(fontId)
	SetTextProportional(1)
	SetTextColour(250, 250, 250, 255)		-- You can change the text color here
	SetTextDropshadow(1, 1, 1, 1, 255)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(textInput)
	SetDrawOrigin(x,y,z+2, 0)
	DrawText(0.0, 0.0)
	ClearDrawOrigin()
end