local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('LENT:NIGHTCLUB:ENTER:NIGHTCLUB', function()
    EnterLocation()
end)

RegisterNetEvent('LENT:NIGHTCLUB:EXIT:NIGHTCLUB', function()
    ExitLocation()
end)

CreateThread(function()
    while true do
        Wait(0)
        for k, v in pairs(Config.NightclubEntry) do
            exports['qb-target']:AddBoxZone(v["name"], v["coords"], v["height"], v["width"], {
                name = v["name"],
                heading = v["heading"],
                debugPoly = v["debug"],
                minZ = v["minZ"],
                maxZ = v["maxZ"],
                }, {
                    options = {
                        {
                            type = 'client',
                            event = 'LENT:NIGHTCLUB:ENTER:NIGHTCLUB',
                            icon = v["icon"],
                            label = v["label"],
                        },
                    },
                distance = 3.5
            })
        end

        for k, v in pairs(Config.NightclubExit) do
            exports['qb-target']:AddBoxZone(v["name"], v["coords"], v["height"], v["width"], {
                name = v["name"],
                heading = v["heading"],
                debugPoly = v["debug"],
                minZ = v["minZ"],
                maxZ = v["maxZ"],
                }, {
                    options = {
                        {
                            type = 'client',
                            event = 'LENT:NIGHTCLUB:EXIT:NIGHTCLUB',
                            icon = v["icon"],
                            label = v["label"],
                        },
                    },
                distance = 3.5
            })
        end
    end
end)

-- [[ Doors ]] --
CreateThread(function()
	TriggerServerEvent('LENT:DOORLOCK:GET:DOORSTATE')
end)

RegisterNetEvent('LENT:DOORLOCK:RETURN:DOORSTATE')
AddEventHandler('LENT:DOORLOCK:RETURN:DOORSTATE', function(states)
	for index, state in pairs(states) do
		Doorlock.DoorsList[index].locked = state
	end
end)

RegisterNetEvent('LENT:DOORLOCK:SET:DOORSTATE')
AddEventHandler('LENT:DOORLOCK:SET:DOORSTATE', function(index, state) 
    Doorlock.DoorsList[index].locked = state
end)

CreateThread(function()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId())

		for k, v in ipairs(Doorlock.DoorsList) do

			if v.doors then
				for k2,v2 in ipairs(v.doors) do
					if v2.object and DoesEntityExist(v2.object) then
						if k2 == 1 then
							v.distanceToPlayer = #(playerCoords - GetEntityCoords(v2.object))
						end

						if v.locked and v2.objHeading and round(GetEntityHeading(v2.object)) ~= v2.objHeading then
							SetEntityHeading(v2.object, v2.objHeading)
						end
					else
						v.distanceToPlayer = nil
						v2.object = GetClosestObjectOfType(v2.objCoords, 1.0, v2.objHash, false, false, false)
					end
				end
			else
				if v.object and DoesEntityExist(v.object) then
					v.distanceToPlayer = #(playerCoords - GetEntityCoords(v.object))

					if v.locked and v.objHeading and round(GetEntityHeading(v.object)) ~= v.objHeading then
						SetEntityHeading(v.object, v.objHeading)
					end
				else
					v.distanceToPlayer = nil
					v.object = GetClosestObjectOfType(v.objCoords, 1.0, v.objHash, false, false, false)
				end
			end
		end

		Wait(500)
	end
end)

function round(n)
	return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

CreateThread(function()
	while true do
		Wait(0)
		local letSleep = true

		for k, v in ipairs(Doorlock.DoorsList) do
			if v.distanceToPlayer and v.distanceToPlayer < 50 then
				letSleep = false

				if v.doors then
					for k2, v2 in ipairs(v.doors) do
						FreezeEntityPosition(v2.object, v.locked)
					end
				else
					FreezeEntityPosition(v.object, v.locked)
				end
			end

			if v.distanceToPlayer and v.distanceToPlayer < v.maxDistance then
				if QBCore.Functions.HasItem('nightclub_keycard') and IsControlJustReleased(0, 23) then
                    exports['ps-ui']:VarHack(function(success)
                        if success then
                            TriggerServerEvent('LENT:DOORLOCK:CHECK:PERM', k, not v.locked)
                        else
                            exports['ps-dispatch']:nightclubRobbery()
                        end
                    end, 3, 5) -- Number of Blocks, Time (seconds)
				end
			end
		end

		if letSleep then
			Wait(500)
		end
	end
end)

