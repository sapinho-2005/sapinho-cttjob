ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--base

	
RegisterServerEvent('Ctt:cash')
AddEventHandler('Ctt:cash', function(currentJobPay)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addMoney(currentJobPay)
		
	TriggerClientEvent('esx:showNotification', _source, ' Ganhas-te' .. currentJobPay .. '€')
end)	