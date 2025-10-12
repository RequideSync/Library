function UILibrary.Section:Dropdown(sett, callback)
	local functions = {}
	functions.__index = functions

	local cheatBase = generateCheatBase("Dropdown", sett)
	cheatBase.Parent = self.Section.Border.Content
	cheatBase.LayoutOrder = getLayoutOrder(self.Section.Border.Content)

	local element = cheatBase.Content.ElementContent.Dropdown

	local slot = element.Slot:Clone()
	element.Slot:Destroy()

	local bottom = element.Bottom:Clone()
	element.Bottom:Destroy()

	local top = element.Top:Clone()
	element.Top:Destroy()

	local conns = {}
	local menuOpen = false

	local options = sett.Options ~= nil and sett.Options or {}
	local selectedOptions = {}

	local optionConnections = {}

	-- ====== Search Box ======
	local searchBox = Instance.new("TextBox")
	searchBox.Name = "SearchBox"
	searchBox.Parent = element.OptionHolder.ContentHolder
	searchBox.AnchorPoint = Vector2.new(0,0)
	searchBox.Position = UDim2.new(0,0,0,0)
	searchBox.Size = UDim2.new(1,0,0,25)
	searchBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
	searchBox.TextColor3 = Color3.fromRGB(255,255,255)
	searchBox.PlaceholderText = "Search..."
	searchBox.TextScaled = true

	-- ====== UI Refresh ======
	functions.refreshUI = function()
		local String = ""

		for i, v in pairs(options) do
			local ui = element.OptionHolder.ContentHolder.Content:FindFirstChild(i)
			if ui then
				ui.Visible = i:lower():find(searchBox.Text:lower()) and true or false

				if options[i] then
					TweenService:Create(ui.Select, TI, {ImageTransparency = 0}):Play()
					if String == "" then
						String = i
					else
						String = String .. ", " .. i
					end
				else
					TweenService:Create(ui.Select, TI, {ImageTransparency = 1}):Play()
				end
			end
		end

		if String == "" then
			String = "None"
		end

		element.MainHolder.Content.Text.Text = String
	end

	-- ====== Set Value ======
	functions.setValue = function(option, value, isDefault)
		if options[option] ~= nil then
			if element.OptionHolder.ContentHolder.Content:FindFirstChild(option) then
				if sett.Multi == true then
					options[option] = value
					functions.refreshUI()
				else
					if value == true then
						for i,v in pairs(options) do options[i] = false end
						if isDefault == nil then functions.openMenu() end
						options[option] = true
						functions.refreshUI()
					end
				end
				callback(options)
			end
		end
	end

	-- ====== Update Dropdown ======
	local function updateDropdown()
		for _, v in pairs(element.OptionHolder.ContentHolder.Content:GetChildren()) do
			if v:IsA("GuiObject") and v ~= searchBox then v:Destroy() end
		end

		for _, conn in pairs(optionConnections) do conn:Disconnect() end
		optionConnections = {}

		local counter = 0
		local totalCounter = 0
		for _,_ in pairs(options) do totalCounter = totalCounter + 1 end

		for name,_ in pairs(options) do
			counter = counter + 1
			local Option
			if counter == totalCounter then
				Option = bottom:Clone()
			elseif counter ~= 1 then
				Option = slot:Clone()
			else
				Option = top:Clone()
			end

			Option.Name = name
			Option.Parent = element.OptionHolder.ContentHolder.Content
			Option.LayoutOrder = counter
			Option.Size = UDim2.fromScale(1, 1 / totalCounter)
			Option.Current.Text = name

			table.insert(optionConnections, Option.InputBegan:Connect(function(input, gp)
				if gp then return end
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					functions.setValue(name, not options[name])
				elseif input.UserInputType == Enum.UserInputType.MouseMovement then
					TweenService:Create(Option, TI, {ImageColor3 = Color3.fromRGB(20,20,20)}):Play()
				end
			end))

			table.insert(optionConnections, Option.InputEnded:Connect(function(input, gp)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					TweenService:Create(Option, TI, {ImageColor3 = Color3.fromRGB(25,25,25)}):Play()
				end
			end))
		end
	end

	updateDropdown()

	functions.updateDropdown = function(new)
		options = new
		updateDropdown()
		functions.refreshUI()
	end

	searchBox:GetPropertyChangedSignal("Text"):Connect(function()
		functions.refreshUI()
	end)

	-- ====== Open Menu ======
	functions.openMenu = function()
		local totalCounter = 0
		for _,_ in pairs(options) do totalCounter = totalCounter + 1 end
		if totalCounter == 0 then return end

		menuOpen = not menuOpen
		if menuOpen then
			TweenService:Create(element.MainHolder.Content.Icon.Holder, TI, {Rotation=180}):Play()
			TweenService:Create(element.OptionHolder, TI, {Size=UDim2.fromScale(1, math.clamp(totalCounter,0,999)*.7)}):Play()
			element.OptionHolder.Visible = true
		else
			TweenService:Create(element.MainHolder.Content.Icon.Holder, TI, {Rotation=0}):Play()
			TweenService:Create(element.OptionHolder, TI, {Size=UDim2.fromScale(1,0)}):Play()
			task.delay(.4,function() if not menuOpen then element.OptionHolder.Visible = false end end)
		end
	end

	functions.getValue = function() return options end

	if sett.Default then
		functions.setValue(sett.Default,true,true)
	end

	local meta = setmetatable({element=element, UI=cheatBase}, functions)
	self.oldSelf.oldSelf.oldSelf.UI[self.oldSelf.oldSelf.categoryUI.Name][self.oldSelf.SectionName][self.Section.Name][sett.Title] = meta

	return meta
end
