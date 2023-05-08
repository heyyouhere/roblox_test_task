local trash = workspace.Trash


trash.ProximityPrompt.Triggered:Connect(function(player)
	local store = game.ReplicatedStorage:FindFirstChild(player.UserId)
	local items = store:GetDescendants()
	for i=1, #items do
		local item = items[i]
		if item:IsA('IntValue') then
			item.Value = 0
		end
	end
end)
