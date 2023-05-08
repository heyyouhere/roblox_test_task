local DataStore2 = require(game.ServerScriptService.Modules.DataStore2)
local MainKey = game.ServerScriptService.MainKey.Value
local MYDS = require(game.ServerScriptService.Modules.MYDS)


local moneyBag = workspace.MoneyBag
local STATE_NAME = 'Money'

DataStore2.Combine(MainKey, 'money')

game.Players.PlayerAdded:Connect(function(player) 
	local moneyStore = DataStore2('money', player)
	local value = moneyStore:Get(0)
	MYDS.createReplicatedValue(player, STATE_NAME, 'money', value)	
end)

game.Players.PlayerRemoving:Connect(function(player)
	MYDS.clearUp(player, STATE_NAME)	
end)


moneyBag.ProximityPrompt.Triggered:Connect(function(player)
	local money = game.ReplicatedStorage:FindFirstChild(player.UserId).Money.money
	money.Value += 500	
end)
