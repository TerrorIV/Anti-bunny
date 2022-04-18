TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread( function(eventName)
	local resetCounter = 0
	local jumpDisabled = false
  	
  	while true do
        Citizen.Wait(100)

		if jumpDisabled and resetCounter > 0 and IsPedJumping(PlayerPedId()) and not (GetPedParachuteState(PlayerPedId()) == 1)then
			SetPedToRagdoll(PlayerPedId(), 500, 500, 3, 0, 0, 0)
			ESX.ShowNotification('Tu t\'es cru pour un kangourou à sauter comme ça ?')
			resetCounter = 0
		end

		if not jumpDisabled and IsPedJumping(PlayerPedId()) then
			jumpDisabled = true
			resetCounter = 10
			Citizen.Wait(1200)
		end

		if resetCounter > 0 then
			resetCounter = resetCounter - 1
		else
			if jumpDisabled then
				resetCounter = 0
				jumpDisabled = false
			end
		end
	end
end)
