local DataStore2 = require(game.ServerScriptService.Modules.DataStore2)

local DS = {}



function DS.createReplicatedValue(player, stateName, itemName, value)
	if not game.ReplicatedStorage:FindFirstChild(player.UserId) then
		local values = Instance.new('Configuration', game.ReplicatedStorage)
		values.Name = player.UserId
	end
	if not game.ReplicatedStorage:FindFirstChild(player.UserId):FindFirstChild(stateName) then
		local state = Instance.new('Configuration', game.ReplicatedStorage:FindFirstChild(player.UserId))
		state.Name = stateName
	end
	local state = game.ReplicatedStorage:FindFirstChild(player.UserId):FindFirstChild(stateName)
	local itemCount = Instance.new('IntValue', state)
	itemCount.Name = itemName
	itemCount.Value = value
	itemCount.Changed:Connect(function(value) 
		local itemStore = DataStore2(itemName, player)
		itemStore:Set(value)
	end)
end


function DS.clearUp(player, stateName)
	local state = game.ReplicatedStorage:FindFirstChild(player.UserId)
	state:Destroy()
end



return DS
