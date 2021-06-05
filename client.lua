local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
func = Tunnel.getInterface("emp_pizza")

local expediente = false
local pizzas = 0

local garagens = {
    [1] = {x=124.08805847168,y=-1472.2384033203,z=29.14161491394},
    [2] = {x=127.19618988037,y=-1474.7060546875,z=29.14161491394},
    [3] = {x=129.63829040527,y=-1476.7635498047,z=29.14161491394}
}

local entregas = {
	[1] = { x=153.21, y=-1027.81, z=28.91, xp=152.29, yp=-1032.64, zp=29.33 },
	[2] = { x=288.75, y=-590.05, z=42.76, xp=282.95, yp=-593.66, zp=43.37},
	[3] = { x=-428.63, y=-194.59, z=36.15, xp=-425.09, yp=-192.15, zp=36.68 },
	[4] = { x=-771.53, y=291.97, z=85.28, xp=-772.61, yp=296.56, zp=85.71 },
	[5] = { x=-1643.72, y=140.42, z=61.59, xp=-1645.87, yp=143.92, zp=62.08 },
	[6] = { x=-1862.60, y=-353.79, z=48.84, xp=-1861.03, yp=-351.28, zp=49.28 },
	[7] = { x=-1158.43, y=-1415.72, z=4.38, xp=-1156.02, yp=-1419.32, zp=4.82 },
	[8] = { x=-829.03, y=-1217.71, z=6.54, xp=-826.87, yp=-1220.68, zp=6.93 },
	[9] = { x=-107.01, y=-1687.99, z=28.87, xp=-111.08, yp=-1686.72, zp=29.30 },
	[10] = { x=398.98, y=-1898.78, z=24.84, xp=401.04, yp=-1902.28, zp=25.24 },
	[11] = { x=301.38, y=-1441.79, z=29.40, xp=297.37, yp=-1445.61, zp=29.91 },
	[12] = { x=1190.77, y=-1444.70, z=34.70, xp=1190.34, yp=-1448.80, zp=35.09 },
	[13] = { x=1379.00, y=-2074.09, z=51.60, xp=1381.71, yp=-2077.92, zp=51.99 },
	[14] = { x=1044.08, y=-2386.68, z=29.85, xp=1048.06, yp=-2387.75, zp=30.39 },
	[15] = { x=437.06, y=-1993.40, z=22.73, xp=440.48, yp=-1991.29, zp=23.18 },
	[16] = { x=-233.06, y=-986.11, z=28.86, xp=-237.46, yp=-985.73, zp=29.28 },
	[17] = { x=-104.75, y=-609.90, z=35.67, xp=-108.87, yp=-608.21, zp=36.26 },
	[18] = { x=228.21, y=198.26, z=104.92, xp=230.79, yp=201.85, zp=105.41 },
	[19] = { x=1191.81, y=-408.65, z=67.32, xp=1187.03, yp=-408.24, zp=67.79 },
	[20] = { x=409.07, y=-806.81, z=28.87, xp=413.31, yp=-807.42, zp=29.31 },
	[21] = { x=-178.78, y=-1148.58, z=22.65, xp=-179.17, yp=-1152.97, zp=23.08 } 
}

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
			local ped = PlayerPedId()
			local px,py,pz = table.unpack(GetEntityCoords(ped,true)) 
            local distancia = GetDistanceBetweenCoords(143.46499633789,-1462.3302001953,29.357028961182,px,py,pz,true)
        if expediente then
            if distancia <= 50 then
                if distancia <= 1.5 then 
                    DrawText3Ds(143.46499633789,-1462.3302001953,29.667046127319,"PRESSIONE ~g~E~w~ PARA PEGAR PIZZAS")
                if IsControlJustPressed(0,153) and not IsPedInAnyVehicle(ped,false) then 
					if pizzas < 5 then
                    print("PEGOU!")
                    local prop_name = 'prop_michael_backpack'
					local playerPed = GetPlayerPed(-1)
					Citizen.CreateThread(function()
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						DeleteObject(prop)
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 24818), 0.046, -0.17, -0.040, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
					end)
					pizzas  = pizzas + 5
					print(pizzas)
					else
					TriggerEvent("Notify","negado","Voce ja pegou as pizzas")
					end
				    end
			    end
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
			local ped = PlayerPedId()
			local px,py,pz = table.unpack(GetEntityCoords(ped,true)) 
            local distancia = GetDistanceBetweenCoords(133.05709838867,-1462.8317871094,29.357046127319,px,py,pz,true)
			if not expediente then
            if distancia <= 50 then
                if distancia <= 1.5 then
                    DrawText3Ds(133.05709838867,-1462.8317871094,29.667046127319,"PRESSIONE ~g~E~w~ PARA INICIAR EXPEDIENTE")
                if IsControlJustPressed(0,153) and not IsPedInAnyVehicle(ped,false) then
                    print("Sucesso")
					TriggerEvent("Notify","sucesso","Voce iniciou o expediente")
					destino = math.random(1,21)
					CriandoBlip(entregas,destino)
					expediente = true
					Citizen.Wait(10)
				end
			end
		end
		end
		if expediente then
		if distancia <= 50 then
                if distancia <= 1.5 then
                    DrawText3Ds(133.05709838867,-1462.8317871094,29.667046127319,"PRESSIONE ~g~E~w~ PARA FINALIZAR EXPEDIENTE")
                if IsControlJustPressed(0,153) and not IsPedInAnyVehicle(ped,false) then
                    print("FINALIZADO!")
					TriggerEvent("Notify","sucesso","Voce finalizou o expediente")
					expediente = false
					DeleteObject(prop)
					Citizen.Wait(10)
				end
			end
		end
	end
		
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
			local ped = PlayerPedId()
			local px,py,pz = table.unpack(GetEntityCoords(ped,true)) 
            local distancia = GetDistanceBetweenCoords(134.66088867188,-1473.2181396484,29.357028961182,px,py,pz,true)
        if expediente then
            if distancia <= 50 then
                if distancia <= 1.5 then 
                    DrawText3Ds(134.66088867188,-1473.2181396484,29.667046127319,"PRESSIONE ~g~E~w~ PARA PEGAR MOTOCICLETA")
                if IsControlJustPressed(0,153) and not IsPedInAnyVehicle(ped,false) then 
                    local vehicleName = 'faggio' -- Veiculo de entrega

                    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then            
                        return
                    end
                
                    
                    RequestModel(vehicleName)

                    while not HasModelLoaded(vehicleName) do
                        Wait(500) 
                    end    

                    if HasModelLoaded(vehicleName) then
                    local garagenrand = math.random(1,3)
                    local vehicle = CreateVehicle(vehicleName,garagens[garagenrand].x,garagens[garagenrand].y,garagens[garagenrand].z, 320, true, false) 
                    SetVehicleIsStolen(vehicle,false)
                    SetVehicleOnGroundProperly(vehicle)
                    SetEntityInvincible(vehicle,false)
                    SetVehicleNumberPlateText(vehicle, "  PIZZA")
                    Citizen.InvokeNative(0xAD738C3085FE7E11,vehicle,true,true)
                    SetVehicleHasBeenOwnedByPlayer(vehicle,true)
                    SetVehicleDirtLevel(vehicle,0.0)
                    SetVehRadioStation(vehicle,"OFF")
                    SetVehicleDoorsLocked(vehicle,1)
                    SetVehicleDoorsLockedForAllPlayers(vehicle,false)
                    SetVehicleDoorsLockedForPlayer(vehicle,PlayerId(),false)
                    SetVehicleEngineOn(GetVehiclePedIsIn(PlayerId(),false),true)
                    SetModelAsNoLongerNeeded(vehicleName)
                    end
					TriggerEvent("Notify","sucesso","Veiculo Retirado")
					
				    end
			    end
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		Citizen.Wait(1)
		if expediente then
			local ui = GetMinimapAnchor()
			if IsControlJustPressed(0,57) then	
				statuses = not statuses
			end
			if statuses then
				drawTxt(ui.right_x+0.680,ui.bottom_y-0.046,1.0,1.0,0.35,"PRESSIONE ~r~F11 ~w~PARA CANCELAR A MISSÃO",255,255,255,150)
				drawTxt(ui.right_x+0.680,ui.bottom_y-0.028,1.0,1.0,0.45,"ENTREGE AS PIZZAS NO LOCAL MARCADO",255,255,255,255)
			else
				drawTxt(ui.right_x+0.680,ui.bottom_y-0.028,1.0,1.0,0.35,"PRESSIONE ~r~F10 ~w~PARA VER A MISSÃO",255,255,255,150)
			end
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			local vehicle = GetVehiclePedIsUsing(PlayerPedId())
			if distance <= 50 then
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z+0.10,0,0,0,0,180.0,130.0,2.0,2.0,1.0,211,176,72,100,1,0,0,1)
				if distance <= 3 then
					DrawText3Ds(entregas[destino].x,entregas[destino].y,entregas[destino].z, "PRESSIONE ~g~E ~s~ PARA ENTREGAR")
					if IsControlJustPressed(0,153) and not IsPedInAnyVehicle(ped,false) then
						if pizzas > 0 then
						destinoantigo = destino
						RemoveBlip(blip)
						TriggerEvent("progress",5000,"Entregando")
						vRP.CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_02",50,28422)
						FreezeEntityPosition(PlayerPedId(),true)
						TriggerEvent('cancelando',true)
						SetTimeout(5000,function()
						TriggerEvent('cancelando',false)
						FreezeEntityPosition(PlayerPedId(),false)
						ClearPedTasks(PlayerPedId())
						vRP.DeletarObjeto()
						func.pizzaentrega()
						pizzas = pizzas - 1
						end)
							while true do
								if destinoantigo == destino then
									destino = math.random(1,21)
								else
									break
								end
								Citizen.Wait(1)
							end
						CriandoBlip(entregas,destino)
						else
							TriggerEvent("Notify","negado","Voce nao tem pizzas")
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function() -- verificador de pizzas
	while true do
	    Citizen.Wait(500)
		if pizzas <= 0 then 
			DeleteObject(prop)
			Citizen.Wait(300)
		end		
	end
end)

Citizen.CreateThread(function() -- Cancelar
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,344) and expediente then
			expediente = false
			RemoveBlip(blip)
			local vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
			if DoesEntityExist(ped) then
				TaskLeaveVehicle(ped,vehicle,262144)
				Citizen.Wait(1100)
				SetVehicleDoorShut(vehicle,3,0)
				Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(ped))
			elseif DoesEntityExist(ped2) then
				TaskLeaveVehicle(ped2,vehicle,262144)
				Citizen.Wait(1100)
				SetVehicleDoorShut(vehicle,3,0)
				Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(ped2))
			end
			ped = nil
			ped2 = nil
		end
	end
end)

function DrawText3Ds(x,y,z, text) -- TEXTO 3D
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent("destranc")
AddEventHandler("destranc",function(index)
		local v = NetToVeh(index)
		local locked = GetVehicleDoorLockStatus(v)
		SetVehicleDoorsLocked(v,1)
end)

function CriandoBlip(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Pizza")
	EndTextCommandSetBlipName(blip)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function drawTxt(x,y,width,height,scale,text,r,g,b,a)
    SetTextFont(4)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end