local HUD = game.Players.LocalPlayer.PlayerGui:WaitForChild('HUD')
local money_store = game.ReplicatedStorage:WaitForChild(game.Players.LocalPlayer.UserId).Money.money



HUD.Frame.TextLabel.Text = money_store.Value .. '$'

money_store.Changed:Connect(function(value)
	HUD.Frame.TextLabel.Text = tostring(value) .. '$'
end)



local items = game.ReplicatedStorage:WaitForChild(game.Players.LocalPlayer.UserId).Items:GetChildren()
HUD.Frame.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0.2 * #items, 0)
for i=1, #items do
	local item = items[i]
	local itemName = Instance.new('TextLabel', HUD.Frame.ScrollingFrame)
	itemName.Position = UDim2.new(0, 0, 0.2 * (i-1), 0)
	itemName.Size = UDim2.new(0.5,0,0.2,0)
	itemName.Text = item.Name
	itemName.RichText = true
	--itemName.TextScaled = true

	local itemValue = Instance.new('TextLabel', HUD.Frame.ScrollingFrame)
	itemValue.Position = UDim2.new(0.5, 0, 0.2 * (i -1), 0)
	itemValue.Size = UDim2.new(0.5,0,0.2,0)
	itemValue.Text = item.Value
	itemValue.RichText = true
	--itemValue.TextScaled = true
	
	item.Changed:Connect(function(value)
		itemValue.Text = item.Value
	end)
end


local warnignGUi = game.Players.LocalPlayer.PlayerGui.Warning 
function notEnough()
	warnignGUi.Frame.TextLabel.Text = 'Not enough money!'
	warnignGUi.Enabled = true 
	wait(3)
	warnignGUi.Enabled = false
end
function alreadyBought()
	warnignGUi.Frame.TextLabel.Text = 'You already have a car!'
	warnignGUi.Enabled = true 
	wait(3)
	warnignGUi.Enabled = false
end

game.ReplicatedStorage.NotEnoughMoney.OnClientInvoke = notEnough 
game.ReplicatedStorage.AlreadyBought.OnClientInvoke = alreadyBought
--print(store.money.Value)


