local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("emp_pizza",func)

function func.pizzaentrega()
	local user_id = vRP.getUserId(source)
	if user_id then
		pagamento = math.random(200,450) -- Economia Dinheiro Entrega
		vRP.giveMoney(user_id,pagamento)
	end
end