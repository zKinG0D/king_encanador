-------------------------------------------------------------------------------------
-- CREDITS πΎπππ#8563 --       CONEXΓO PROXY & TUNNEL          -- CREDITS πΎπππ#8563 --
-------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

kinG = {}
Tunnel.bindInterface("king_empEncanador",kinG)

-------------------------------------------------------------------------------------
-- CREDITS πΎπππ#8563 --               FUNΓΓES                 -- CREDITS πΎπππ#8563 --
-------------------------------------------------------------------------------------

-- Colocar Roupa --
RegisterServerEvent('king_empEncanador:roupa')
AddEventHandler('king_empEncanador:roupa', function()
	local source = source
	local user_id = vRP.getUserId(source)

    if user_id then
		vRP.removeCloak(source)
	end
end)

function kinG.SaveIdleCustom(old_custom)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.save_idle_custom(source,old_custom)
end

-- Dar Ferramentas --
function kinG.giveFerramentas()
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        if vRP.getInventoryWeight()+vRP.getItemWeight("ferramenta") <= vRP.getInventoryMaxWeight(user_id) then
            vRP.giveInventoryItem(user_id,'ferramenta',3)
            return true
        else
            TriggerClientEvent('Notify', source, 'negado', '<b>Mochila</b> cheia!')
            return false
        end
    end
end

-- Pagamento --
function kinG.payment()
    local source = source
    local user_id = vRP.getUserId(source)
    local quantidade = math.random(1,3)

    if user_id then
        if vRP.tryGetInventoryItem(user_id, 'ferramenta', quantidade) then
            randmoney = math.random(300,600)
            vRP.giveMoney(user_id, randmoney)
            TriggerClientEvent('Notify', source, 'sucesso', 'VocΓͺ recebeu <b>$'..randmoney..'</b> pelo serviΓ§o!')
            TriggerClientEvent('vrp_sound:source', source, 'coins', 0.5)
        else
            TriggerClientEvent('Notify', source, 'negado', 'VocΓͺ precisa de <b>'..quantidade..'x</b> Ferramentas!')
        end
    end
end
