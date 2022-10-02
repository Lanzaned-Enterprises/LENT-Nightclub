local QBCore = exports['qb-core']:GetCoreObject()

local doorState = {}

RegisterServerEvent('LENT:DOORLOCK:UPDATE:DOORSTATE')
AddEventHandler('LENT:DOORLOCK:UPDATE:DOORSTATE', function(doorIndex, state)
	local player = source;
	if type(doorIndex) == 'number' and type(state) == 'boolean' and Doorlock.DoorsList[doorIndex] then
		doorState[doorIndex] = state
		TriggerClientEvent('LENT:DOORLOCK:SET:DOORSTATE', -1, doorIndex, state)
		return;
    end	
end)

RegisterNetEvent('LENT:DOORLOCK:GET:DOORSTATE')
AddEventHandler('LENT:DOORLOCK:GET:DOORSTATE', function()
	TriggerClientEvent('LENT:DOORLOCK:RETURN:DOORSTATE', -1, doorState);
end)

RegisterNetEvent('LENT:DOORLOCK:CHECK:PERM')
AddEventHandler('LENT:DOORLOCK:CHECK:PERM', function(doorV, state)
	local player = source;
	if type(doorV) == 'number' and Doorlock.DoorsList[doorV] then
		doorState[doorV] = state;
		TriggerClientEvent('LENT:DOORLOCK:SET:DOORSTATE', -1, doorV, state)
		return;
	end
end)
