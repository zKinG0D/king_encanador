-------------------------------------------------------------------------------------
-- CREDITS 𝐾𝑖𝑛𝑔#8563 --       CONEXÃO PROXY & TUNNEL          -- CREDITS 𝐾𝑖𝑛𝑔#8563 --
-------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
kinG = Tunnel.getInterface("king_empEncanador")

-------------------------------------------------------------------------------------
-- CREDITS 𝐾𝑖𝑛𝑔#8563 --              VARIÁVEIS                -- CREDITS 𝐾𝑖𝑛𝑔#8563 --
-------------------------------------------------------------------------------------
local processo = false
local pegouVan = false
local pegou_ferramentas = false
local animacao = false
local locais = 0

-- Coordenada do blip para Começar o Trabalho
local iniciarTrabalhoX = 499.78
local iniciarTrabalhoY = -1963.55
local iniciarTrabalhoZ = 24.99

-- Coordenada do blip para Pegar a Van
local pegarVanX = 501.52
local pegarVanY = -1966.36
local pegarVanZ = 24.99

-- Coordenada para Spawnar a Van
local spawnVanX = 496.28
local spawnVanY = -1974.0
local spawnVanZ = 24.73
-- Direção para onde a Van vai spawnar
local vanHeading = 122.66

-- Coordenada do blip para pegar ferramentas
local pegarFerramentasX = 482.82
local pegarFerramentasY = -1963.33
local pegarFerramentasZ = 24.84

-- Coordenadas de locais de concertos
local concertos = {
    [1] = { ['x'] = -1560.74, ['y'] = 23.53, ['z'] = 59.56 },
	[2] = { ['x'] = -1032.92, ['y'] = 349.39, ['z'] = 71.37 },
    [3] = { ['x'] = -798.38, ['y'] = 175.85, ['z'] = 72.84 },
	[4] = { ['x'] = -820.32, ['y'] = 106.88, ['z'] = 56.55 },
	[5] = { ['x'] = -843.46, ['y'] = -13.18, ['z'] = 39.89 },
	[6] = { ['x'] = -1127.7, ['y'] = 307.63, ['z'] = 66.18 }, 
	[7] = { ['x'] = -900.8, ['y'] = 99.6, ['z'] = 55.11 },
	[8] = { ['x'] = -1476.82, ['y'] = -339.75, ['z'] = 45.44 },
	[9] = { ['x'] = 158.7, ['y'] = -284.7, ['z'] = 46.31 },
	[10] = { ['x'] = 67.26, ['y'] = -1387.56, ['z'] = 29.35 },
	[11] = { ['x'] = 17.71, ['y'] = -1300.08, ['z'] = 29.38 },
	[12] = { ['x'] = -16.18, ['y'] = -1076.93, ['z'] = 26.68 },
	[13] = { ['x'] = -218.67, ['y'] = -1165.74, ['z'] = 23.02 },
    [14] = { ['x'] = -806.15, ['y'] = -957.62, ['z'] = 15.29 },
	[15] = { ['x'] = 424.22, ['y'] = -995.81, ['z'] = 30.72 },
	[16] = { ['x'] = 141.92, ['y'] = -292.32, ['z'] = 46.31 }
}

-------------------------------------------------------------------------------------
-- CREDITS 𝐾𝑖𝑛𝑔#8563 --               FUNÇÕES                 -- CREDITS 𝐾𝑖𝑛𝑔#8563 --
-------------------------------------------------------------------------------------

-- Iniciar Trabalho --
Citizen.CreateThread(function()
    while true do
        local king = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz,cdz = GetGroundZFor_3dCoord(iniciarTrabalhoX, iniciarTrabalhoY, iniciarTrabalhoZ)
        local distance = GetDistanceBetweenCoords(iniciarTrabalhoX, iniciarTrabalhoY, cdz, x, y, z, true)

        if not processo then
            if distance <= 4 then
                king = 1
                DrawMarker(27,iniciarTrabalhoX,iniciarTrabalhoY,iniciarTrabalhoZ-1.0,0,0,0,0.0,0,0,0.8,0.8,0.8,0, 255, 58,70,0,1,0,1)
                DrawMarker(2,iniciarTrabalhoX,iniciarTrabalhoY,iniciarTrabalhoZ-0.4,0,0,0,0.0,0,0,0.4,0.4,0.4,0, 255, 58,70,1,1,0,0)
                
                if distance <= 1.2 then
                    drawText("~w~PRESSIONE ~g~[E] ~w~PARA INICIAR O SERVIÇO")

                    if IsControlJustPressed(0, 38) then
                        colocarRoupa()
                        TriggerEvent('Notify', 'importante', 'Você entrou em Serviço, Solicite sua Van!')
                        processo = true
                        locais = math.random(1,16)
                        criarBlips(concertos, locais)
                    end
                end
            end
        end
        Citizen.Wait(king)
    end
end)

-- Pegar Van --
Citizen.CreateThread(function()
    while true do
        local king = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz,cdz = GetGroundZFor_3dCoord(pegarVanX, pegarVanY, pegarVanZ)
        local distance = GetDistanceBetweenCoords(pegarVanX, pegarVanY, cdz, x, y, z, true)

        if processo and not pegouVan then
            if distance <= 4 then
                king = 1
                DrawMarker(27,pegarVanX,pegarVanY,pegarVanZ-1.0,0,0,0,0.0,0,0,0.8,0.8,0.8,0, 255, 58,70,0,1,0,1)
                DrawMarker(36,pegarVanX,pegarVanY,pegarVanZ+0.1,0,0,0,0.0,0,0,0.8,0.8,0.8,0, 255, 58,70,0,1,0,0)

                if distance <= 1.2 then
                    drawText("~w~PRESSIONE ~g~[E] ~w~PARA ALUGAR VAN DE SERVIÇO")

                    if IsControlJustPressed(0, 38) then
                        fade(1200)
                        pegouVan = true
                        spawnVan()
                        TriggerEvent('Notify', 'importante', 'Van entregue, Pegue suas ferramentas!')
                    end
                end
            end
        end
        Citizen.Wait(king)
    end
end)

-- Pegar Ferramentas --
Citizen.CreateThread(function()
    while true do
        local king = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz,cdz = GetGroundZFor_3dCoord(pegarFerramentasX, pegarFerramentasY, pegarFerramentasZ)
        local distance = GetDistanceBetweenCoords(pegarFerramentasX, pegarFerramentasY, cdz, x, y, z, true)

        if pegouVan and not pegou_ferramentas then
            if distance <= 4 then
                king = 1
                DrawMarker(27,pegarFerramentasX,pegarFerramentasY,pegarFerramentasZ-1.0,0,0,0,0.0,0,0,0.8,0.8,0.8,0, 255, 58,70,0,1,0,1)
                DrawMarker(3,pegarFerramentasX,pegarFerramentasY,pegarFerramentasZ-0.2,0,0,0,0.0,0,0,0.3,0.3,0.3,0, 255, 58,100,1,1,0,0)

                if distance <= 1.2 then
                    DrawText3D(pegarFerramentasX,pegarFerramentasY,pegarFerramentasZ+0.2,"~b~[E] ~w~Pegar Ferramentas",1.2,1)

                    if IsControlJustPressed(0, 38) then
                        SetEntityHeading(ped, 305.76)
                        vRP._playAnim(false,{{"anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator"}},true)
                        TriggerEvent('Notify', 'importante', 'Coletando Ferramentas, Aguarde!')
                        TriggerEvent('progress', 5000, 'COLETANDO FERRAMENTAS')
                        FreezeEntityPosition(ped, true)
                        Wait(5000)
                        ClearPedTasks(ped)
                        FreezeEntityPosition(ped, false)
                        kinG.giveFerramentas()
                        TriggerEvent('Notify', 'sucesso', 'Ferramentas Coletadas, Vá atender clientes!')
                    end
                end
            end
        end
        Citizen.Wait(king)
    end
end)

-- Concertos --
Citizen.CreateThread(function()
    while true do
        local king = 1000

        if processo then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(concertos[locais].x,concertos[locais].y,concertos[locais].z)
			local distance = GetDistanceBetweenCoords(concertos[locais].x,concertos[locais].y,cdz,x,y,z,true)

			if distance < 10 then
				king = 1
				if distance < 2 then
					king = 5
                    DrawText3D(x,y,z+1.2,"~b~[E] ~w~Para Consertar o Cano",1.2,1)

					if IsControlJustPressed(0, 38) then
						TriggerEvent("progress",10000,"Consertando o cano")
						RemoveBlip(blips)
						animacao = true
						if animacao then
							vRP._playAnim(false,{{"mini@repair","fixing_a_player"}},true)
							disableCmds()
							Citizen.Wait(10000)
							ClearPedTasks(ped)
							kinG.payment()
							animacao = false
							locais = math.random(1,16)
							criarBlips(concertos, locais)
						end
					end	
				end
			end
        end
        Citizen.Wait(king)
    end
end)

-------------------------------------------------------------------------------------
-- CREDITS 𝐾𝑖𝑛𝑔#8563 --           FUNÇÕES ADICIONAIS          -- CREDITS 𝐾𝑖𝑛𝑔#8563 --
-------------------------------------------------------------------------------------

-- Cancelar Trabalho --
Citizen.CreateThread(function()
    while true do
        local king = 1

        if IsControlJustPressed(0, 168) and processo then
            TriggerEvent('Notify', 'importante', 'Você cancelou o serviço!')
            resetar()
            mainRoupa()
            vRP.playSound("Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET")
            RemoveBlip(blips)

            if nveh then
                DeleteVehicle(nveh)
                nveh = nil
            end
        end
        Citizen.Wait(king)
    end
end)

-- Blip do Mapa --
Citizen.CreateThread(function()
    blips = AddBlipForCoord(498.48, -1966.43, 24.86) -- Coordenada do BLIP
	SetBlipSprite(blips,446)
	SetBlipColour(blips,25)
	SetBlipScale(blips,0.8)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Emprego | Encanador") -- Texto do BLIP
	EndTextCommandSetBlipName(blips)
end)

-- Criar Blips --
function criarBlips(concertos, locais)
    blips = AddBlipForCoord(concertos[locais].x,concertos[locais].y,concertos[locais].z)
	SetBlipSprite(blips,544)
	SetBlipColour(blips,25)
	SetBlipScale(blips,1.0)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Concertar Encanamento") -- Texto do BLIP
	EndTextCommandSetBlipName(blips)
end

-- Para escrever texto na tela --
function drawText(texto)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.4)
    SetTextColour(128, 128, 128, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(0, 0, 0, 1, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(texto)
    DrawText(0.36, 0.90)
end

-- Para escrever o texto 3d --
function DrawText3D(x,y,z, text, scl, font) 
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

	local scale = (1/dist)*scl
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov
	if onScreen then
		SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
	end
end

-- Para Spawnar a Van --
function spawnVan()
	local veh = "burrito"
	if not nveh then
	while not HasModelLoaded(veh) do
	    RequestModel(veh)
	    Citizen.Wait(10)
	end
		local ped = PlayerPedId()
		local x,y,z = vRP.getPosition()
		nveh = CreateVehicle(veh,spawnVanX,spawnVanY,spawnVanZ+0.5,vanHeading,true,false)
		SetVehicleIsStolen(nveh,false)
        SetVehRadioStation(nveh,"OFF")
        SetVehicleEngineOn(GetVehiclePedIsIn(ped,false),true)
		SetVehicleOnGroundProperly(nveh)
		SetEntityInvincible(nveh,false)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
        SetModelAsNoLongerNeeded(veh)
		SetVehicleDirtLevel(nveh,0.0)
        Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
	end
end

-- Para escurecer a tela --
function fade(time)
    DoScreenFadeOut(800)
    Wait(time)
    DoScreenFadeIn(800)
end

-- Para desabilitar comandos --
function disableCmds()
	Citizen.CreateThread(function()
		while true do
            local king = 1
			Citizen.Wait(king)
			if animacao then
				BlockWeaponWheelThisFrame()
				DisableControlAction(0,16,true)
				DisableControlAction(0,17,true)
				DisableControlAction(0,24,true)
				DisableControlAction(0,25,true)
				DisableControlAction(0,29,true)
				DisableControlAction(0,56,true)
				DisableControlAction(0,57,true)
				DisableControlAction(0,73,true)
				DisableControlAction(0,166,true)
				DisableControlAction(0,167,true)
				DisableControlAction(0,170,true)				
				DisableControlAction(0,182,true)	
				DisableControlAction(0,187,true)
				DisableControlAction(0,188,true)
				DisableControlAction(0,189,true)
				DisableControlAction(0,190,true)
				DisableControlAction(0,243,true)
				DisableControlAction(0,245,true)
				DisableControlAction(0,257,true)
				DisableControlAction(0,288,true)
				DisableControlAction(0,289,true)
				DisableControlAction(0,344,true)		
			end	
		end
	end)
end

-- Para colocar a roupa de encanador --
function fadeRoupa(time, tipo, idle_copy)
    DoScreenFadeOut(800)
    Wait(time)
    if tipo == 1 then
        vRP.setCustomization(idle_copy)
    else
        TriggerServerEvent('king_empEncanador:roupa')
    end
    DoScreenFadeIn(800)
end

local roupaEncanador = {
    ["Encanador"] = {
		[1885233650] = {                                      
            [1] = { 0,0 },
            [2] = { 72,0 },
            [3] = { 33,0 },
            [4] = { 39,1 },
            [5] = { 41,0 },
            [6] = { 25,0 },
            [7] = { 0,0 },
            [8] = { 15,0 },
            [10] = { 0,0 },
            [11] = { 66,1 },
            ["p0"] = { 58,2 },
            ["p1"] = { 0,0 }
        },
        [-1667301416] = {
            [1] = { 0,0 },
            [2] = { 72,0 },
            [3] = { 57,0 },
            [4] = { 49,0 },
            [5] = { 41,0 },
            [6] = { 36,0 },
            [7] = { 0,0 },
            [8] = { 56,0 },
            [9] = { 0,0 },
            [10] = { 0,0 },
            [11] = { 88,0 },
            ["p0"] = { 58,0 },
            ["p1"] = { -1,0 }
        }
	} 
}

function colocarRoupa()
    if vRP.getHealth() > 101 then
        if not vRP.isHandcuffed() then
            local custom = roupaEncanador["Encanador"]
            if custom then
                local old_custom = vRP.getCustomization()
                local idle_copy = {}

                idle_copy = kinG.SaveIdleCustom(old_custom)
				idle_copy.modelhash = nil

                for l,w in pairs(custom[old_custom.modelhash]) do
                    idle_copy[l] = w
                end
                fadeRoupa(1200,1,idle_copy)
            end
        end
    end
end

function mainRoupa()
    if vRP.getHealth() > 101 then
		if not vRP.isHandcuffed() then
	        fadeRoupa(1200,2)
	    end
	end
end

-- Resetar Variáveis --
function resetar()
    processo = false
    pegouVan = false
    pegou_ferramentas = false
    animacao = false
    locais = 0
end
