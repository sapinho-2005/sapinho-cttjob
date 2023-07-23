local Keys = {
   ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
   ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
   ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
   ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
   ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
   ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
   ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
   ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
   ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
 }
 
 local PlayerData              = {}
 
 ESX = nil
 
 Citizen.CreateThread(function()
    while ESX == nil do
       TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
       Citizen.Wait(0)
    end
    
    while ESX.GetPlayerData().job == nil do
       Citizen.Wait(10)
    end
 
    PlayerData = ESX.GetPlayerData()
    
    CreateBlip()	
 end)
 
 RegisterNetEvent('esx:setJob')
 AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
     CreateBlip()	
    Citizen.Wait(5000)
 end)
 
 --------------------------------------
 
 local currentJob = {}
 local restockObject = {}
 local restockObjectLocation = {}
 local onJob = false 
 local CttVehicle = nil
 local currentJobPay = 0
 local PackageObject = nil
 local currentPackages = 0
 local locations = {
    ["LosSantos"] = {
       ['Max'] = 22,
       [1] = {-153.19, -838.31, 30.12},
       [2] = {37.72, -795.71, 30.93},
       [3] = {111.7, -809.56, 30.71},
       [4] = {132.61, -889.41, 29.71},
       [5] = {54.41, -994.86, 28.7},
       [6] = {142.87, -1026.78, 28.67}, 
       [7] = {248.03, -1005.49, 28.61},
       [8] = {275.68, -929.64, 28.47},
       [9] = {294.29, -877.33, 28.61},
       [10] = {247.68, -832.03, 29.16},
       [11] = {211.33, -605.63, 41.42}, 
       [12] = {126.27, -555.46, 42.66},
       [13] = {254.2, -377.17, 43.96},
       [14] = {244.49, 349.05, 105.46},
       [15] = {130.77, -307.27, 44.58},
       [16] = {54.44, -280.4, 46.9}, 
       [17] = {55.15, -225.54, 50.44},
       [18] = {44.6, -138.99, 54.66},
       [19] = {32.51, -162.61, 54.86},
       [20] = {-29.6, -110.84, 56.51},
       [21] = {-95.78, -87.84, 57.80},
       [22] = {-146.26, -71.46, 53.9},
    },
 }
 
 local restockLocations = {
  [1] = { 14.7056, -2689.5222, 6.0106},
  [2] = { 14.8239, -2691.9827, 6.0102},
  [3] = { 12.5662, -2688.3496, 6.0090},
  [4] = { 12.1323, -2690.0627, 6.0089},
  [5] = { 12.2285, -2692.6492, 6.0405},
  [6] = { 13.9631, -2685.9382, 6.0099},
  [7] = { 10.9675, -2686.0964, 6.0089},
  [8] = { 12.0418, -2696.1797, 6.0096, 181.6276}
 }
 
 local vehicleSpawnLocations = {
  {x = 74.09, y = 120.90, z = 79.2, h = 158.44},
  {x = 69.43, y = 122.80, z = 79.2, h = 158.44},
 }

  function CreateBlip()
      if PlayerData.job ~= nil and PlayerData.job.name == 'ctt' then

         if BlipCloakRoom == nil then
            BlipCloakRoom = AddBlipForCoord(33.7097, -2650.6489, 5.7349)
            SetBlipSprite(BlipCloakRoom, 269)
            SetBlipColour(BlipCloakRoom, 47)
            SetBlipScale(BlipCloakRoom, 0.9)
            SetBlipAsShortRange(BlipCloakRoom, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Armazém CTT')
            EndTextCommandSetBlipName(BlipCloakRoom)
         end	
      end
   end
    
 
 
 Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   if PlayerData.job ~= nil and PlayerData.job.name == 'ctt' then
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 78.899, 111.934, 81.1, true) < 15) then
    DrawMarker(2, 78.899, 111.934, 81.1, 0, 0, 0, 0.0, 0, 0, 0.3, 0.3, 0.1, 50, 255, 255, 255, 0, 0, 0, 0)
       if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 78.899, 111.934, 81.1, true) < 1.5) then
        if DoesEntityExist(CttVehicle) then DrawText3d(78.899, 111.934, 81.1+0.4, Config.localeterminar, 200) else DrawText3d(78.899, 111.934, 81.1+0.4, Config.localecomecar, 200) end	
        if IsControlJustPressed(0, 38) then 
         if DoesEntityExist(CttVehicle) then 
          onJob = false
       DeleteVehicle(CttVehicle)
       RemoveJobBlip()
 
       local plate = GetVehicleNumberPlateText(CttVehicle)
       TriggerServerEvent('garage:addKeys', plate)
         else
          local freespot, v = getParkingPosition(vehicleSpawnLocations)
       if freespot then SpawnCtt(v.x, v.y, v.z, v.h) end
     exports['okokNotify']:Alert("CTT", Config.localeonduty, 3000, 'info')
     exports['okokNotify']:Alert("CTT", Config.localearmazem, 3000, 'info')
       --TriggerEvent("pNotify:SendNotification", {text= "<font color='yellow'>Go Round The Back of The Warehouse To Fill Your Truck"})  
       end
      end
    end
    end
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 34.9996, -2650.9680, 6.0051, true) < 40) and IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey(Config.carro)) and DoesEntityExist(CttVehicle) then
       DrawMarker(2, 34.9996, -2650.9680, 6.0051, 0, 0, 0, 0.0, 0, 0, 0.3, 0.3, 0.1, 50, 255, 255, 255, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 34.9996, -2650.9680, 6.0051, true) < 4) then
     if not onJob then 
      DrawText3d(34.9996, -2650.9680, 6.0051+0.4, Config.localestock, 200)
      
      
      
      
      if IsControlJustPressed(0, 38) then
       restockVan()
      end
      end
     end
    end
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), currentJob[1], currentJob[2], currentJob[3], true) < 20) and onJob then
       DrawMarker(1, currentJob[1], currentJob[2], currentJob[3], 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 112, 100,210, true, true, 0,0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), currentJob[1], currentJob[2], currentJob[3], true) < 1.5) then
     drawTxt(Config.localeentregarcaixa)
     if IsControlJustPressed(0, 38) then
      DeleteObject(PackageObject)
      ClearPedTasks(GetPlayerPed(-1))
      PackageObject = nil 
      TriggerServerEvent('Ctt:cash', currentJobPay)
      
      newShift()
     end
     end
    end
    if onJob and not IsPedInAnyVehicle(GetPlayerPed(-1)) and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), currentJob[1], currentJob[2], currentJob[3], true) < 20 then 
     local bootPos = GetEntityCoords(CttVehicle)
     if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bootPos.x, bootPos.y, bootPos.z, true) < 2.5 and PackageObject == nil then 
      drawTxt(Config.localecaixa)
     
      if IsControlJustPressed(0, 38) then
      LoadModel("prop_cardbordbox_02a")
      local pos = GetEntityCoords(GetPlayerPed(-1), false)
      PackageObject = CreateObject(GetHashKey("prop_cardbordbox_02a"), pos.x, pos.y, pos.z, true, true, true)
       AttachEntityToEntity(PackageObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
       LoadAnim("anim@heists@box_carry@")
       TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
      end
     end 
    end
   end
  end
 end)
 
 
 function restockVan()
  local restockPackages = 8
  local restockVan = true
  local carryingPackage = {status = false, id = nil}
  for id,v in pairs(restockLocations) do 
   restockObject[id] = CreateObject(GetHashKey("prop_cardbordbox_02a"), v[1],v[2],v[3]-0.95, true, true, true)
   restockObjectLocation[id] = v 
   PlaceObjectOnGroundProperly(restockObject[id])
  end
  while restockVan do 
   Wait(1)
   for id,v in pairs(restockObjectLocation) do 
    DrawMarker(2, v[1],v[2],v[3], 0,0,0,0,0,0,0.3,0.3,0.1,50,255,255,165,0,0,0,0)
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v[1],v[2],v[3], true) < 1.0 then
     drawTxt(Config.localecaixa)
     if IsControlJustPressed(0, 38) then 
      AttachEntityToEntity(restockObject[id], PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
      LoadAnim("anim@heists@box_carry@")
      TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
      carryingPackage.status = true
      carryingPackage.id = id
     end
    end
   end
   if carryingPackage.status then 
    local bootPos = GetEntityCoords(CttVehicle)
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bootPos.x, bootPos.y, bootPos.z, true) < 2.6 then 
     drawTxt(Config.localecolocarcaixa)
     if IsControlJustPressed(0, 38) then 
      DeleteObject(restockObject[carryingPackage.id])
      ClearPedTasks(GetPlayerPed(-1))
      carryingPackage.status = false
      restockObjectLocation[carryingPackage.id] = {}
      restockObject[carryingPackage.id] = nil
      restockPackages = restockPackages-1
      if restockPackages == 0 then 
       restockVan = false
       newShift()
      onJob = true
      exports['okokNotify']:Alert("CTT", Config.localestockpronto, 3000, 'info')
      end
     end
    end
   end
  end
 end
 
 function newShift()
  local id = 1
  if id == 1 then 
    local jobLocation = locations['LosSantos'][math.random(1, locations['LosSantos']['Max'])] 
    SetJobBlip(jobLocation[1],jobLocation[2],jobLocation[3])
    currentJob = jobLocation
  end
 
 currentJobPay = CalculateTravelDistanceBetweenPoints(GetEntityCoords(GetPlayerPed(-1)), currentJob[1],currentJob[2],currentJob[3])/2/4
    if currentJobPay > 100 then
       currentJobPay = round((currentJobPay / 2), 0)
       if currentJobPay > 450 then
          currentJobPay = 450
       end
       return
    elseif currentJobPay > 60 then
       currentJobPay = math.random(70,100)
       return
    end
 end
 
 function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
 end
 
 function SpawnCtt(x,y,z,h)
  local vehicleHash = GetHashKey(Config.carro)
  RequestModel(vehicleHash)
  while not HasModelLoaded(vehicleHash) do
   Citizen.Wait(0)
  end
 
  CttVehicle = CreateVehicle(vehicleHash, x, y, z, h, true, false)
  local id = NetworkGetNetworkIdFromEntity(CttVehicle)
  SetNetworkIdCanMigrate(id, true)
  SetNetworkIdExistsOnAllMachines(id, true)
  SetVehicleDirtLevel(CttVehicle, 0)
  SetVehicleHasBeenOwnedByPlayer(CttVehicle, true)
  SetEntityAsMissionEntity(CttVehicle, true, true)
  SetVehicleEngineOn(CttVehicle, true)
 end