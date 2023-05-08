local DEFAULT_COST = 10
local DEFAULT_LIMIT = 1
local STATE_NAME = 'BuyOnce'
--Using DataStore2 as unofficial standart https://kampfkarren.github.io/Roblox/
--Mode is set to 'Standart' for easier CloudAPI parsing in Future

local DataStore2 = require(game.ServerScriptService.Modules.DataStore2)
local MYDS = require(game.ServerScriptService.Modules.MYDS)
local MainKey = game.ServerScriptService.MainKey.Value


function initStore(storeFolder)
	--Creating DataStore entry for every !UNIQUE! named item in the store
	local storeItems = storeFolder:GetChildren()
	game.Players.PlayerAdded:Connect(function(player) 
		for i=1, #storeItems do
			DataStore2.Combine(MainKey, storeItems[i].Name)
			--Creates or returns value from DS2
			local itemStore = DataStore2(storeItems[i].Name, player)
			local value = itemStore:Get(0)
			MYDS.createReplicatedValue(player, STATE_NAME, storeItems[i].Name, value)
		end
	end)

	--Creating ProximityPrompt for each item in shop
	for i=1, #storeItems do	
		local item = storeItems[i]
		local prompt = Instance.new('ProximityPrompt', item)
		prompt.ActionText = 'Buy ' .. item.Name
		if not item:FindFirstChild('Cost') then
			local cost = Instance.new('IntValue', item)
			cost.Name = 'Cost'
			cost.Value = math.random(100, 1000)
		end
		prompt.ObjectText = item.Cost.Value .. ' $'

		--Setting behaivor on prompt triggered
		prompt.Triggered:Connect(function(player)
			local moneyValue = game.ReplicatedStorage:FindFirstChild(player.UserId).Money.money
			local isItemOwned = game.ReplicatedStorage:FindFirstChild(player.UserId):FindFirstChild(STATE_NAME):FindFirstChild(item.Name).Value
			if isItemOwned > 0  then
				game.ReplicatedStorage.AlreadyBought:InvokeClient(player)
				return nil				
			end			
			if moneyValue.Value < item.Cost.Value then
				game.ReplicatedStorage.NotEnoughMoney:InvokeClient(player)
				return nil
			end
			local itemValue = game.ReplicatedStorage:FindFirstChild(player.UserId):FindFirstChild(STATE_NAME):FindFirstChild(item.Name)
			itemValue.Value += 1
			moneyValue.Value -= item.Cost.Value
		end)		
	end

end


initStore(workspace.BuyOnce)
