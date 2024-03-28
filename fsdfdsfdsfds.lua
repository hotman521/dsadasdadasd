repeat task.wait() until game:IsLoaded()

local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local uis = game:GetService("UserInputService")
local stats = game:GetService("Stats")

local viewport = workspace.CurrentCamera.ViewportSize
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local zindexcount = 999

local function wait_for_child(parent, child)
	local child = parent:WaitForChild(child);
	while not child do
		child = parent:WaitForChild(child);
	end;
	return child;
end;

local Library = {
	Flags = {},
	UnnamedFlags = 0,
}

local keys = {
	[Enum.KeyCode.LeftShift] = "L-SHIFT",
	[Enum.KeyCode.RightShift] = "R-SHIFT",
	[Enum.KeyCode.LeftControl] = "L-CTRL",
	[Enum.KeyCode.RightControl] = "R-CTRL",
	[Enum.KeyCode.LeftAlt] = "L-ALT",
	[Enum.KeyCode.RightAlt] = "R-ALT",
	[Enum.KeyCode.CapsLock] = "CAPSLOCK",
	[Enum.KeyCode.Home] = "HOME",
	[Enum.KeyCode.PageUp] = "PAGE-UP",
	[Enum.KeyCode.PageDown] = "PAGE-DOWN",
	[Enum.KeyCode.End] = "END",
	[Enum.KeyCode.Tab] = "TAB",
}

local blacklisted_keys = {
	[Enum.KeyCode.W] = true,
	[Enum.KeyCode.A] = true,
	[Enum.KeyCode.S] = true,
	[Enum.KeyCode.D] = true,
	[Enum.KeyCode.Space] = true,
	[Enum.KeyCode.Escape] = true,
	[Enum.KeyCode.Backspace] = true,
	[Enum.KeyCode.Slash] = true,
	[Enum.KeyCode.Delete] = true,
	[Enum.KeyCode.Insert] = true,
	[Enum.UserInputType.MouseButton1] = true,
	[Enum.UserInputType.MouseButton2] = true,
	[Enum.UserInputType.MouseButton3] = true,
	[Enum.KeyCode.One] = true,
	[Enum.KeyCode.Two] = true,
	[Enum.KeyCode.Three] = true,
	[Enum.KeyCode.Four] = true,
	[Enum.KeyCode.Five] = true,
	[Enum.KeyCode.Six] = true,
	[Enum.KeyCode.Seven] = true,
	[Enum.KeyCode.Eight] = true,
	[Enum.KeyCode.Nine] = true,
	[Enum.KeyCode.Zero] = true,
}

local enums = {}
local Notifications = {}

local Scaling = {True = false, Origin = nil, Size = nil}
local Dragging = {Gui = nil, True = false}
local Draggables = {}

function Library:Validate(defaults, options)
	for i, v in pairs(defaults) do
		if options[i] == nil then
			options[i] = v
		end
	end
	return options
end
--
function Library:tween(object, goal, callback)
	local tween = tweenService:Create(object, tweenInfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end
--
local function GetDictionaryLength(Dictionary: table)
	local Length = 0
	for _ in pairs(Dictionary) do
		Length += 30
	end
	return Length
end
--
function Library:NewFlag()
	Library.UnnamedFlags += 1
	--
	return tostring(Library.UnnamedFlags)
end
--
function Library:Window(options)
	options = Library:Validate({
		Name = "UI Library",
		Side = "Left",
		CloseBind = Enum.KeyCode.RightControl,
		KeybindList = false,
		Watermark = false,
		Indicators = false,
	}, options or {})

	local GUI = {
		CurrentTab = nil,
		Hover = false,
	}

	do -- Main Frame
		GUI["1"] = Instance.new("ScreenGui", runService:IsStudio() and players.LocalPlayer:WaitForChild("PlayerGui") or coreGui);
		GUI["1"]["Name"] = [[MyLibrary]];
		GUI["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
		GUI["1"]["ResetOnSpawn"] = false;
		GUI["1"]["IgnoreGuiInset"] = true;

		-- StarterGui.MyLibrary.MainBackground
		GUI["2"] = Instance.new("Frame", GUI["1"]);
		GUI["2"]["BorderSizePixel"] = 0;
		GUI["2"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31);
		GUI["2"]["AnchorPoint"] = Vector2.new(0, 0);
		GUI["2"]["Size"] = UDim2.new(0, 800, 0, 600);
		GUI["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["2"]["Position"] = UDim2.fromOffset((viewport.X / 2) - (GUI["2"].Size.X.Offset / 2), (viewport.Y / 2) - (GUI["2"].Size.Y.Offset / 2));
		GUI["2"]["Name"] = [[MainBackground]];
		GUI["2"]["ZIndex"] = 5;

		-- StarterGui.MyLibrary.MainBackground.UIStroke
		GUI["3"] = Instance.new("UIStroke", GUI["2"]);
		GUI["3"]["Color"] = Color3.fromRGB(20, 20, 20);
		GUI["3"]["LineJoinMode"] = Enum.LineJoinMode.Miter;

		-- StarterGui.MyLibrary.MainBackground.DropShadowHolder
		GUI["4"] = Instance.new("Frame", GUI["2"]);
		GUI["4"]["ZIndex"] = 0;
		GUI["4"]["BorderSizePixel"] = 0;
		GUI["4"]["BackgroundTransparency"] = 1;
		GUI["4"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["4"]["Name"] = [[DropShadowHolder]];

		-- StarterGui.MyLibrary.MainBackground.DropShadowHolder.DropShadow
		GUI["5"] = Instance.new("ImageLabel", GUI["4"]);
		GUI["5"]["ZIndex"] = 0;
		GUI["5"]["BorderSizePixel"] = 0;
		GUI["5"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
		GUI["5"]["ScaleType"] = Enum.ScaleType.Slice;
		GUI["5"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["5"]["ImageTransparency"] = 0.5;
		GUI["5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["5"]["Image"] = [[rbxassetid://6014261993]];
		GUI["5"]["Size"] = UDim2.new(1, 55, 1, 55);
		GUI["5"]["Name"] = [[DropShadow]];
		GUI["5"]["BackgroundTransparency"] = 1;
		GUI["5"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

		-- StarterGui.MyLibrary.MainBackground.TopBar
		GUI["57"] = Instance.new("Frame", GUI["2"]);
		GUI["57"]["ZIndex"] = 2;
		GUI["57"]["BorderSizePixel"] = 0;
		GUI["57"]["BackgroundColor3"] = Color3.fromRGB(24, 24, 24);
		GUI["57"]["Size"] = UDim2.new(1, 0, 0, 25);
		GUI["57"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["57"]["Position"] = UDim2.new(-5.1747466756069116e-08, 0, 4.09169338411175e-08, 0);
		GUI["57"]["Name"] = [[TopBar]];

		-- StarterGui.MyLibrary.MainBackground.TopBar.Close
		GUI["58"] = Instance.new("ImageLabel", GUI["57"]);
		GUI["58"]["ZIndex"] = 2;
		GUI["58"]["AnchorPoint"] = Vector2.new(0, 0.5);
		GUI["58"]["BorderSizePixel"] = 0;
		GUI["58"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["58"]["ImageColor3"] = Color3.fromRGB(216, 216, 216);
		GUI["58"]["Image"] = [[rbxassetid://15269329696]];
		GUI["58"]["ImageRectSize"] = Vector2.new(256, 256);
		GUI["58"]["Size"] = UDim2.new(0, 16, 0, 16);
		GUI["58"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["58"]["Name"] = [[Close]];
		GUI["58"]["ImageRectOffset"] = Vector2.new(0, 514);
		GUI["58"]["BackgroundTransparency"] = 1;
		GUI["58"]["Position"] = UDim2.new(0.97, 0, 0.5, 0);

		-- StarterGui.MyLibrary.MainBackground.TopBar.TextLabel
		GUI["59"] = Instance.new("TextLabel", GUI["57"]);
		GUI["59"]["BorderSizePixel"] = 0;
		GUI["59"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["59"]["TextXAlignment"] = Enum.TextXAlignment[options.Side];
		GUI["59"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		GUI["59"]["TextSize"] = 14;
		GUI["59"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
		GUI["59"]["Size"] = UDim2.new(1, 0, 0, 25);
		GUI["59"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["59"]["RichText"] = true;
		GUI["59"]["Text"] = options["Name"];
		GUI["59"]["BackgroundTransparency"] = 1;

		-- StarterGui.MyLibrary.MainBackground.TopBar.TextLabel.UIPadding
		GUI["5a"] = Instance.new("UIPadding", GUI["59"]);
		GUI["5a"]["PaddingBottom"] = UDim.new(0, 2);
		GUI["5a"]["PaddingLeft"] = UDim.new(0, 27);

		-- StarterGui.MyLibrary.MainBackground.TopBar.Icon
		GUI["5b"] = Instance.new("ImageLabel", GUI["57"]);
		GUI["5b"]["ZIndex"] = 2;
		GUI["5b"]["BorderSizePixel"] = 0;
		GUI["5b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["5b"]["ImageColor3"] = Color3.fromRGB(0, 255, 0);
		GUI["5b"]["Image"] = [[rbxassetid://16863027979]];
		GUI["5b"]["Size"] = UDim2.new(0, 20, 0, 20);
		GUI["5b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["5b"]["Name"] = [[Icon]];
		GUI["5b"]["BackgroundTransparency"] = 1;
		GUI["5b"]["Position"] = UDim2.new(0.004999999888241291, 0, 0.03799999877810478, 0);
		
		-- StarterGui.MyLibrary.MainBackground.ContentContainer
		GUI["6"] = Instance.new("Frame", GUI["2"]);
		GUI["6"]["BorderSizePixel"] = 0;
		GUI["6"]["BackgroundColor3"] = Color3.fromRGB(21, 21, 21);
		GUI["6"]["AnchorPoint"] = Vector2.new(1, 0);
		GUI["6"]["BackgroundTransparency"] = 1;
		GUI["6"]["Size"] = UDim2.new(1, -80, 0.9330000281333923, 0);
		GUI["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["6"]["Position"] = UDim2.new(1, 0, 0.06700000166893005, 0);
		GUI["6"]["Name"] = [[ContentContainer]];
	end
	
	if options.KeybindList then
		-- StarterGui.MyLibrary.GUI
		GUI["1c"] = Instance.new("Frame", GUI["1"]);
		GUI["1c"]["BorderSizePixel"] = 0;
		GUI["1c"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31);
		GUI["1c"]["Size"] = UDim2.new(0, 160, 0, 30);
		GUI["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["1c"]["Position"] = UDim2.fromOffset(10, (viewport.Y / 2) - (GUI["1c"].Size.Y.Offset / 2));
		GUI["1c"]["Name"] = [[GUI]];

		-- StarterGui.MyLibrary.GUI.Bar
		GUI["1d"] = Instance.new("Frame", GUI["1c"]);
		GUI["1d"]["BorderSizePixel"] = 0;
		GUI["1d"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
		GUI["1d"]["Size"] = UDim2.new(1, 0, 0, 3);
		GUI["1d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["1d"]["Name"] = [[Bar]];

		-- StarterGui.MyLibrary.GUI.DropShadowHolder
		GUI["1e"] = Instance.new("Frame", GUI["1c"]);
		GUI["1e"]["ZIndex"] = 0;
		GUI["1e"]["BorderSizePixel"] = 0;
		GUI["1e"]["BackgroundTransparency"] = 1;
		GUI["1e"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["1e"]["Name"] = [[DropShadowHolder]];

		-- StarterGui.MyLibrary.GUI.DropShadowHolder.DropShadow
		GUI["1f"] = Instance.new("ImageLabel", GUI["1e"]);
		GUI["1f"]["ZIndex"] = 0;
		GUI["1f"]["BorderSizePixel"] = 0;
		GUI["1f"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
		GUI["1f"]["ScaleType"] = Enum.ScaleType.Slice;
		GUI["1f"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["1f"]["ImageTransparency"] = 0.5;
		GUI["1f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["1f"]["Image"] = [[rbxassetid://6014261993]];
		GUI["1f"]["Size"] = UDim2.new(1, 30, 1, 30);
		GUI["1f"]["Name"] = [[DropShadow]];
		GUI["1f"]["BackgroundTransparency"] = 1;
		GUI["1f"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

		-- StarterGui.MyLibrary.GUI.Title
		GUI["gg"] = Instance.new("TextLabel", GUI["1c"]);
		GUI["gg"]["BorderSizePixel"] = 0;
		GUI["gg"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["gg"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		GUI["gg"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
		GUI["gg"]["TextSize"] = 14;
		GUI["gg"]["TextColor3"] = Color3.fromRGB(215, 215, 215);
		GUI["gg"]["Size"] = UDim2.new(1, 0, 1, -3);
		GUI["gg"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["gg"]["Text"] = [[Keybinds]];
		GUI["gg"]["Name"] = [[Title]];
		GUI["gg"]["BackgroundTransparency"] = 1;
		GUI["gg"]["Position"] = UDim2.new(0, 0, 0, 3);

		-- StarterGui.MyLibrary.GUI.Title.UIPadding
		GUI["ff"] = Instance.new("UIPadding", GUI["gg"]);
		GUI["ff"]["PaddingLeft"] = UDim.new(0, 7);

		-- StarterGui.MyLibrary.GUI.ContentContainer
		GUI["hh"] = Instance.new("Frame", GUI["1c"]);
		GUI["hh"]["BorderSizePixel"] = 0;
		GUI["hh"]["BackgroundColor3"] = Color3.fromRGB(20, 20, 20);
		GUI["hh"]["Size"] = UDim2.new(1, 0, 0, 0);
		GUI["hh"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["hh"]["Position"] = UDim2.new(0, 0, 1, 0);
		GUI["hh"]["AutomaticSize"] = Enum.AutomaticSize.Y;
		GUI["hh"]["Name"] = [[ContentContainer]];

		-- StarterGui.MyLibrary.GUI.ContentContainer.UIStroke
		GUI["jj"] = Instance.new("UIStroke", GUI["hh"]);
		GUI["jj"]["Color"] = Color3.fromRGB(21, 21, 21);
		
		-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Background.UIListLayout
		GUI["c6"] = Instance.new("UIListLayout", GUI["hh"]);
		GUI["c6"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
		
		function GUI:AddKeybind(Toggle, Key)
			do -- Render
				-- StarterGui.MyLibrary.GUI.ContentContainer.KeybindFrame
				GUI["kk"] = Instance.new("Frame", GUI["hh"]);
				GUI["kk"]["BorderSizePixel"] = 0;
				GUI["kk"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				GUI["kk"]["BackgroundTransparency"] = 1;
				GUI["kk"]["Size"] = UDim2.new(1, 0, 0, 20);
				GUI["kk"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				GUI["kk"]["Name"] = tostring(Toggle);

				-- StarterGui.MyLibrary.GUI.ContentContainer.KeybindFrame.Keybind
				GUI["ll"] = Instance.new("TextLabel", GUI["kk"]);
				GUI["ll"]["BorderSizePixel"] = 0;
				GUI["ll"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				GUI["ll"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				GUI["ll"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				GUI["ll"]["TextSize"] = 14;
				GUI["ll"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				GUI["ll"]["Size"] = UDim2.new(1, 0, 1, 0);
				GUI["ll"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				GUI["ll"]["Text"] = Key ~= "None" and string.format("[%s] %s", tostring(Key), tostring(Toggle)) or string.format("%s", tostring(Toggle));
				GUI["ll"]["Name"] = [[Keybind]];
				GUI["ll"]["BackgroundTransparency"] = 1;

				-- StarterGui.MyLibrary.GUI.ContentContainer.KeybindFrame.Keybind.UIPadding
				GUI["xx"] = Instance.new("UIPadding", GUI["ll"]);
				GUI["xx"]["PaddingBottom"] = UDim.new(0, 2);
				GUI["xx"]["PaddingLeft"] = UDim.new(0, 7);

				-- StarterGui.MyLibrary.GUI.UIStroke
				GUI["zz"] = Instance.new("UIStroke", GUI["1c"]);
				GUI["zz"]["Color"] = Color3.fromRGB(21, 21, 21);
			end
		end

		function GUI:RemoveKeybind(Toggle)
			for i, v in pairs(GUI["hh"]:GetChildren()) do
				if v.Name == Toggle then
					v:Destroy()
				end
			end
		end
		
		do -- Dragging
			local gui = GUI["1c"]

			local dragging
			local dragInput
			local dragStart
			local startPos

			local function update(input)
				local delta = input.Position - dragStart
				gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end

			gui.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = gui.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)

			gui.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)

			uis.InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					update(input)
				end
			end)
		end
	end
	
	if options.Watermark then
		-- StarterGui.MyLibrary.Watermark
		GUI["f"] = Instance.new("Frame", GUI["1"]);
		GUI["f"]["BorderSizePixel"] = 0;
		GUI["f"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31);
		GUI["f"]["Size"] = UDim2.new(0, 160, 0, 30);
		GUI["f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["f"]["Position"] = UDim2.new(0, 100, 0, 9);
		GUI["f"]["Name"] = [[Watermark]];

		-- StarterGui.MyLibrary.Watermark.Bar
		GUI["10"] = Instance.new("Frame", GUI["f"]);
		GUI["10"]["BorderSizePixel"] = 0;
		GUI["10"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
		GUI["10"]["Size"] = UDim2.new(1, 0, 0, 3);
		GUI["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["10"]["Name"] = [[Bar]];

		-- StarterGui.MyLibrary.Watermark.DropShadowHolder
		GUI["11"] = Instance.new("Frame", GUI["f"]);
		GUI["11"]["ZIndex"] = 0;
		GUI["11"]["BorderSizePixel"] = 0;
		GUI["11"]["BackgroundTransparency"] = 1;
		GUI["11"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["11"]["Name"] = [[DropShadowHolder]];

		-- StarterGui.MyLibrary.Watermark.DropShadowHolder.DropShadow
		GUI["12"] = Instance.new("ImageLabel", GUI["11"]);
		GUI["12"]["ZIndex"] = 0;
		GUI["12"]["BorderSizePixel"] = 0;
		GUI["12"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
		GUI["12"]["ScaleType"] = Enum.ScaleType.Slice;
		GUI["12"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["12"]["ImageTransparency"] = 0.5;
		GUI["12"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["12"]["Image"] = [[rbxassetid://6014261993]];
		GUI["12"]["Size"] = UDim2.new(1, 30, 1, 30);
		GUI["12"]["Name"] = [[DropShadow]];
		GUI["12"]["BackgroundTransparency"] = 1;
		GUI["12"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

		-- StarterGui.MyLibrary.Watermark.Text
		GUI["13"] = Instance.new("TextLabel", GUI["f"]);
		GUI["13"]["BorderSizePixel"] = 0;
		GUI["13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["13"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		GUI["13"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
		GUI["13"]["TextSize"] = 14;
		GUI["13"]["TextColor3"] = Color3.fromRGB(215, 215, 215);
		GUI["13"]["Size"] = UDim2.new(1, 0, 1, -3);
		GUI["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["13"]["Text"] = options.Name;
		GUI["13"]["Name"] = [[Text]];
		GUI["13"]["BackgroundTransparency"] = 1;
		GUI["13"]["Position"] = UDim2.new(0, 0, 0, 3);

		-- StarterGui.MyLibrary.Watermark.Text.UIPadding
		GUI["14"] = Instance.new("UIPadding", GUI["13"]);
		GUI["14"]["PaddingLeft"] = UDim.new(0, 7);

		-- StarterGui.MyLibrary.Watermark.UIStroke
		GUI["15"] = Instance.new("UIStroke", GUI["f"]);
		GUI["15"]["Color"] = Color3.fromRGB(21, 21, 21);
		
		function GUI:UpdateWatermark(Text)
			GUI["13"].Text = string.format("LuckyHub | %s", Text)
			GUI["f"].Size = UDim2.new(0, GUI["13"].TextBounds.X + 15, 0, GUI["f"].Size.Y.Offset)
		end

		local temp = tick()
		local Tick = tick()
		--
		if not runService:IsStudio() then
			runService.PreRender:Connect(function()
				local FPS = math.floor(1 / math.abs(temp - tick()))
				temp = tick()
				local Ping = stats.Network:FindFirstChild("ServerStatsItem") and tostring(math.round(stats.Network.ServerStatsItem["Data Ping"]:GetValue())) or "Unknown"
				--
				task.spawn(function()
					if (tick() - Tick) > 0.15 then
						GUI:UpdateWatermark(string.format("Build: Developer | Ping: %s | FPS: %s", tostring(Ping), tostring(FPS)))
						--
						Tick = tick()
					end
				end)
			end)
		end
	end
	
	if options.Indicators then
		do -- Render
			-- StarterGui.MyLibrary.Indicators
			GUI["16"] = Instance.new("Frame", GUI["1"]);
			GUI["16"]["BorderSizePixel"] = 0;
			GUI["16"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31);
			GUI["16"]["Size"] = UDim2.new(0, 240, 0, 30);
			GUI["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			GUI["16"]["Position"] = UDim2.fromOffset(10, (viewport.Y / 2) - (GUI["16"].Size.Y.Offset / 2) - 135);
			GUI["16"]["Name"] = [[Indicators]];

			-- StarterGui.MyLibrary.Indicators.Bar
			GUI["17"] = Instance.new("Frame", GUI["16"]);
			GUI["17"]["BorderSizePixel"] = 0;
			GUI["17"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
			GUI["17"]["Size"] = UDim2.new(1, 0, 0, 3);
			GUI["17"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			GUI["17"]["Name"] = [[Bar]];

			-- StarterGui.MyLibrary.Indicators.DropShadowHolder
			GUI["18"] = Instance.new("Frame", GUI["16"]);
			GUI["18"]["ZIndex"] = 0;
			GUI["18"]["BorderSizePixel"] = 0;
			GUI["18"]["BackgroundTransparency"] = 1;
			GUI["18"]["Size"] = UDim2.new(1, 0, 1, 0);
			GUI["18"]["Name"] = [[DropShadowHolder]];

			-- StarterGui.MyLibrary.Indicators.DropShadowHolder.DropShadow
			GUI["19"] = Instance.new("ImageLabel", GUI["18"]);
			GUI["19"]["ZIndex"] = 0;
			GUI["19"]["BorderSizePixel"] = 0;
			GUI["19"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
			GUI["19"]["ScaleType"] = Enum.ScaleType.Slice;
			GUI["19"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
			GUI["19"]["ImageTransparency"] = 0.5;
			GUI["19"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			GUI["19"]["Image"] = [[rbxassetid://6014261993]];
			GUI["19"]["Size"] = UDim2.new(1, 30, 1, 30);
			GUI["19"]["Name"] = [[DropShadow]];
			GUI["19"]["BackgroundTransparency"] = 1;
			GUI["19"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

			-- StarterGui.MyLibrary.Indicators.Title
			GUI["1a"] = Instance.new("TextLabel", GUI["16"]);
			GUI["1a"]["BorderSizePixel"] = 0;
			GUI["1a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			GUI["1a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			GUI["1a"]["TextSize"] = 14;
			GUI["1a"]["TextColor3"] = Color3.fromRGB(215, 215, 215);
			GUI["1a"]["Size"] = UDim2.new(1, 0, 1, -3);
			GUI["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			GUI["1a"]["Text"] = [[Indicators]];
			GUI["1a"]["Name"] = [[Title]];
			GUI["1a"]["BackgroundTransparency"] = 1;
			GUI["1a"]["Position"] = UDim2.new(0, 0, 0, 3);

			-- StarterGui.MyLibrary.Indicators.ContentContainer
			GUI["1b"] = Instance.new("Frame", GUI["16"]);
			GUI["1b"]["BorderSizePixel"] = 0;
			GUI["1b"]["BackgroundColor3"] = Color3.fromRGB(21, 21, 21);
			GUI["1b"]["Size"] = UDim2.new(1, 0, 0, 0);
			GUI["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			GUI["1b"]["Position"] = UDim2.new(0, 0, 1, 0);
			GUI["1b"]["AutomaticSize"] = Enum.AutomaticSize.Y;
			GUI["1b"]["Name"] = [[ContentContainer]];

			-- StarterGui.MyLibrary.Indicators.ContentContainer.UIStroke
			GUI["2c"] = Instance.new("UIStroke", GUI["1b"]);
			GUI["2c"]["Color"] = Color3.fromRGB(21, 21, 21);

			-- StarterGui.MyLibrary.Indicators.UIStroke
			GUI["3d"] = Instance.new("UIStroke", GUI["16"]);
			GUI["3d"]["Color"] = Color3.fromRGB(21, 21, 21);
			
			-- StarterGui.MyLibrary.Indicators.ContentContainer.TextFrame
			GUI["2d"] = Instance.new("Frame", GUI["1b"]);
			GUI["2d"]["BorderSizePixel"] = 0;
			GUI["2d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			GUI["2d"]["BackgroundTransparency"] = 1;
			GUI["2d"]["Size"] = UDim2.new(1, 0, 0, 20);
			GUI["2d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			GUI["2d"]["Name"] = "TargetFrame";

			-- StarterGui.MyLibrary.Indicators.ContentContainer.TextFrame.Text
			GUI["2e"] = Instance.new("TextLabel", GUI["2d"]);
			GUI["2e"]["BorderSizePixel"] = 0;
			GUI["2e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			GUI["2e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			GUI["2e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			GUI["2e"]["TextSize"] = 14;
			GUI["2e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			GUI["2e"]["Size"] = UDim2.new(0.5, 0, 1, 0);
			GUI["2e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			GUI["2e"]["Text"] = [[Target]];
			GUI["2e"]["Name"] = [[Text]];
			GUI["2e"]["BackgroundTransparency"] = 1;

			-- StarterGui.MyLibrary.Indicators.ContentContainer.TextFrame.Text.UIPadding
			GUI["2f"] = Instance.new("UIPadding", GUI["2e"]);
			GUI["2f"]["PaddingBottom"] = UDim.new(0, 2);
			GUI["2f"]["PaddingLeft"] = UDim.new(0, 7);

			-- StarterGui.MyLibrary.Indicators.ContentContainer.TextFrame.Value
			GUI["20"] = Instance.new("TextLabel", GUI["2d"]);
			GUI["20"]["BorderSizePixel"] = 0;
			GUI["20"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			GUI["20"]["TextXAlignment"] = Enum.TextXAlignment.Right;
			GUI["20"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			GUI["20"]["TextSize"] = 14;
			GUI["20"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			GUI["20"]["Size"] = UDim2.new(0.5, 0, 1, 0);
			GUI["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			GUI["20"]["Text"] = "nil";
			GUI["20"]["Name"] = [[Value]];
			GUI["20"]["BackgroundTransparency"] = 1;
			GUI["20"]["Position"] = UDim2.new(0.5, 0, 0, 0);

			-- StarterGui.MyLibrary.Indicators.ContentContainer.TextFrame.Value.UIPadding
			GUI["21"] = Instance.new("UIPadding", GUI["20"]);
			GUI["21"]["PaddingRight"] = UDim.new(0, 7);
			GUI["21"]["PaddingBottom"] = UDim.new(0, 2);
		end
		
		function GUI:UpdateIndicator(Target)
			if Target ~= nil then
				GUI["20"].Text = Target.Name

				do
					-- StarterGui.MyLibrary.Indicators.ContentContainer.UIListLayout
					GUI["22"] = Instance.new("UIListLayout", GUI["1b"]);
					GUI["22"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

					-- StarterGui.MyLibrary.Indicators.ContentContainer.ArmorSlider
					GUI["23"] = Instance.new("Frame", GUI["1b"]);
					GUI["23"]["BorderSizePixel"] = 0;
					GUI["23"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14);
					GUI["23"]["BackgroundTransparency"] = 1;
					GUI["23"]["LayoutOrder"] = 1;
					GUI["23"]["Size"] = UDim2.new(1, -8, 0, 25);
					GUI["23"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					GUI["23"]["Position"] = UDim2.new(0, 0, 0, 25);
					GUI["23"]["Name"] = [[ArmorSlider]];

					-- StarterGui.MyLibrary.Indicators.ContentContainer.ArmorSlider.Text
					GUI["24"] = Instance.new("TextLabel", GUI["23"]);
					GUI["24"]["TextWrapped"] = true;
					GUI["24"]["BorderSizePixel"] = 0;
					GUI["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					GUI["24"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					GUI["24"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					GUI["24"]["TextSize"] = 14;
					GUI["24"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					GUI["24"]["Size"] = UDim2.new(0.5, 0, 1, -10);
					GUI["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					GUI["24"]["Text"] = [[Health]];
					GUI["24"]["Name"] = [[Text]];
					GUI["24"]["BackgroundTransparency"] = 1;
					GUI["24"]["Position"] = UDim2.new(0, 0, 0, -1);

					-- StarterGui.MyLibrary.Indicators.ContentContainer.ArmorSlider.Value
					GUI["25"] = Instance.new("TextLabel", GUI["23"]);
					GUI["25"]["TextWrapped"] = true;
					GUI["25"]["BorderSizePixel"] = 0;
					GUI["25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					GUI["25"]["TextXAlignment"] = Enum.TextXAlignment.Right;
					GUI["25"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					GUI["25"]["TextSize"] = 12;
					GUI["25"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					GUI["25"]["Size"] = UDim2.new(0.5, 0, 1, -5);
					GUI["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					GUI["25"]["Text"] = [[100]];
					GUI["25"]["Name"] = [[Value]];
					GUI["25"]["BackgroundTransparency"] = 1;
					GUI["25"]["Position"] = UDim2.new(0.5, 0, 0, -6);

					-- StarterGui.MyLibrary.Indicators.ContentContainer.ArmorSlider.Value.UIPadding
					GUI["26"] = Instance.new("UIPadding", GUI["25"]);
					GUI["26"]["PaddingTop"] = UDim.new(0, 8);

					-- StarterGui.MyLibrary.Indicators.ContentContainer.ArmorSlider.SliderBack
					GUI["27"] = Instance.new("Frame", GUI["23"]);
					GUI["27"]["BorderSizePixel"] = 0;
					GUI["27"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14);
					GUI["27"]["AnchorPoint"] = Vector2.new(0, 1);
					GUI["27"]["Size"] = UDim2.new(1, 0, 0, 8);
					GUI["27"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					GUI["27"]["Position"] = UDim2.new(0, 0, 1, 0);
					GUI["27"]["Name"] = [[SliderBack]];

					-- StarterGui.MyLibrary.Indicators.ContentContainer.ArmorSlider.SliderBack.UIStroke
					GUI["28"] = Instance.new("UIStroke", GUI["27"]);
					GUI["28"]["Color"] = Color3.fromRGB(27, 27, 27);

					-- StarterGui.MyLibrary.Indicators.ContentContainer.ArmorSlider.SliderBack.Draggable
					GUI["29"] = Instance.new("Frame", GUI["27"]);
					GUI["29"]["BorderSizePixel"] = 0;
					GUI["29"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
					GUI["29"]["Size"] = UDim2.new(1, 0, 1, 0);
					GUI["29"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					GUI["29"]["Name"] = [[Draggable]];

					-- StarterGui.MyLibrary.Indicators.ContentContainer.ArmorSlider.UIPadding
					GUI["2a"] = Instance.new("UIPadding", GUI["23"]);
					GUI["2a"]["PaddingBottom"] = UDim.new(0, 4);
					GUI["2a"]["PaddingLeft"] = UDim.new(0, 7);

					-- StarterGui.MyLibrary.Indicators.ContentContainer.TextFrame
					GUI["33"] = Instance.new("Frame", GUI["1b"]);
					GUI["33"]["BorderSizePixel"] = 0;
					GUI["33"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					GUI["33"]["BackgroundTransparency"] = 1;
					GUI["33"]["LayoutOrder"] = 3;
					GUI["33"]["Size"] = UDim2.new(1, 0, 0, 20);
					GUI["33"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					GUI["33"]["Name"] = [[TextFrame]];

					-- StarterGui.MyLibrary.Indicators.ContentContainer.TextFrame.Text
					GUI["34"] = Instance.new("TextLabel", GUI["33"]);
					GUI["34"]["BorderSizePixel"] = 0;
					GUI["34"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					GUI["34"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					GUI["34"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					GUI["34"]["TextSize"] = 14;
					GUI["34"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					GUI["34"]["Size"] = UDim2.new(0.5, 0, 1, 0);
					GUI["34"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					GUI["34"]["Text"] = [[Knocked Out]];
					GUI["34"]["Name"] = [[Text]];
					GUI["34"]["BackgroundTransparency"] = 1;

					-- StarterGui.MyLibrary.Indicators.ContentContainer.TextFrame.Text.UIPadding
					GUI["35"] = Instance.new("UIPadding", GUI["34"]);
					GUI["35"]["PaddingBottom"] = UDim.new(0, 2);
					GUI["35"]["PaddingLeft"] = UDim.new(0, 7);

					-- StarterGui.MyLibrary.Indicators.ContentContainer.TextFrame.Value
					GUI["36"] = Instance.new("TextLabel", GUI["33"]);
					GUI["36"]["BorderSizePixel"] = 0;
					GUI["36"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					GUI["36"]["TextXAlignment"] = Enum.TextXAlignment.Right;
					GUI["36"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					GUI["36"]["TextSize"] = 14;
					GUI["36"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					GUI["36"]["Size"] = UDim2.new(0.5, 0, 1, 0);
					GUI["36"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					GUI["36"]["Text"] = [[false]];
					GUI["36"]["Name"] = [[Value]];
					GUI["36"]["BackgroundTransparency"] = 1;
					GUI["36"]["Position"] = UDim2.new(0.5, 0, 0, 0);

					-- StarterGui.MyLibrary.Indicators.ContentContainer.TextFrame.Value.UIPadding
					GUI["37"] = Instance.new("UIPadding", GUI["36"]);
					GUI["37"]["PaddingRight"] = UDim.new(0, 7);
					GUI["37"]["PaddingBottom"] = UDim.new(0, 2);
				end
				
				Target.Character:FindFirstChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
					GUI["25"].Text = math.floor(Target.Character:FindFirstChild("Humanoid").Health)
					GUI["29"].Size = UDim2.new(Target.Character:FindFirstChild("Humanoid").Health / Target.Character:FindFirstChild("Humanoid").MaxHealth, 0, 1, 0)
				end)
			end
		end
		
		function GUI:RemoveIndicators()
			GUI["20"].Text = "nil"

			for i, v in pairs(GUI["1b"]:GetChildren()) do
				if v.Name ~= "TargetFrame" then
					v:Destroy()
				end
			end
		end
		
		do -- Dragging
			local gui = GUI["16"]

			local dragging
			local dragInput
			local dragStart
			local startPos

			local function update(input)
				local delta = input.Position - dragStart
				gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end

			gui.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = gui.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)

			gui.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)

			uis.InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					update(input)
				end
			end)
		end
	end
	
	function GUI:KeybindListVisibility()
		GUI["1c"].Visible = not GUI["1c"].Visible
	end

	function GUI:WatermarkVisibility()
		GUI["f"].Visible = not GUI["f"].Visible
	end
	
	function GUI:IndicatorVisibility()
		GUI["16"].Visible = not GUI["16"].Visible
	end
	
	uis.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		
		if input.KeyCode == options.CloseBind then
			GUI["2"].Visible = not GUI["2"].Visible
		end
	end)
	
	do -- Navigation
		-- StarterGui.MyLibrary.MainBackground.Navigation
		GUI["46"] = Instance.new("Frame", GUI["2"]);
		GUI["46"]["BorderSizePixel"] = 0;
		GUI["46"]["BackgroundColor3"] = Color3.fromRGB(24, 24, 24);
		GUI["46"]["Size"] = UDim2.new(0, 80, 1, -26);
		GUI["46"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["46"]["Position"] = UDim2.new(0, 0, 0, 26);
		GUI["46"]["Name"] = [[Navigation]];

		-- StarterGui.MyLibrary.MainBackground.Navigation.ButtonHolder
		GUI["47"] = Instance.new("Frame", GUI["46"]);
		GUI["47"]["BorderSizePixel"] = 0;
		GUI["47"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["47"]["BackgroundTransparency"] = 1;
		GUI["47"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["47"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["47"]["Name"] = [[ButtonHolder]];

		-- StarterGui.MyLibrary.MainBackground.Navigation.ButtonHolder.UIPadding
		GUI["48"] = Instance.new("UIPadding", GUI["47"]);

		-- StarterGui.MyLibrary.MainBackground.Navigation.ButtonHolder.UIListLayout
		GUI["49"] = Instance.new("UIListLayout", GUI["47"]);
		GUI["49"]["Padding"] = UDim.new(0, 1);
		GUI["49"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
	end

	do -- Logic
		workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
			local viewport2 = workspace.CurrentCamera.ViewportSize
			
			GUI["2"]["Position"] = UDim2.fromOffset((viewport2.X / 2) - (GUI["2"].Size.X.Offset / 2), (viewport2.Y / 2) - (GUI["2"].Size.Y.Offset / 2));
			GUI["16"]["Position"] = UDim2.fromOffset(10, (viewport2.Y / 2) - (GUI["16"].Size.Y.Offset / 2) - 135);
			GUI["1c"]["Position"] = UDim2.fromOffset(10, (viewport2.Y / 2) - (GUI["1c"].Size.Y.Offset / 2));
		end)

		GUI["58"].MouseEnter:Connect(function()
			GUI.Hover = true
		end)

		GUI["58"].MouseLeave:Connect(function()
			GUI.Hover = false
		end)


		uis.InputBegan:Connect(function(input, gpe)
			if gpe then return end

			if input.UserInputType == Enum.UserInputType.MouseButton1 and GUI.Hover then
				GUI["1"]:Destroy()
			end
		end)
	end

	function GUI:CreateTab(options)
		options = Library:Validate({
			Name = "Main",
			Icon = "rbxassetid://16863175349",
			PlayerList = false,
			SkinList = false
		}, options or {})

		local Tab = {
			Hover = false,
			Active = false,
		}
		
			-- Render
			do
				-- StarterGui.MyLibrary.MainBackground.Navigation.ButtonHolder.Inactive
				Tab["4e"] = Instance.new("Frame", GUI["47"]);
				Tab["4e"]["BorderSizePixel"] = 0;
				Tab["4e"]["BackgroundColor3"] = Color3.fromRGB(24, 24, 24);
				Tab["4e"]["BackgroundTransparency"] = 0;
				Tab["4e"]["Size"] = UDim2.new(1, 0, 0, 80);
				Tab["4e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Tab["4e"]["Name"] = [[Inactive]];

				-- StarterGui.MyLibrary.MainBackground.Navigation.ButtonHolder.Inactive.Main
				Tab["4f"] = Instance.new("TextLabel", Tab["4e"]);
				Tab["4f"]["TextWrapped"] = true;
				Tab["4f"]["BorderSizePixel"] = 0;
				Tab["4f"]["TextScaled"] = true;
				Tab["4f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Tab["4f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Tab["4f"]["TextSize"] = 14;
				Tab["4f"]["TextColor3"] = Color3.fromRGB(124, 124, 124);
				Tab["4f"]["Size"] = UDim2.new(1, 0, 0, 16);
				Tab["4f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Tab["4f"]["Text"] = options["Name"];
				Tab["4f"]["Name"] = [[Main]];
				Tab["4f"]["BackgroundTransparency"] = 1;
				Tab["4f"]["Position"] = UDim2.new(0, 0, 0.5249999761581421, 0);

				-- StarterGui.MyLibrary.MainBackground.Navigation.ButtonHolder.Inactive.Icon
				Tab["50"] = Instance.new("ImageLabel", Tab["4e"]);
				Tab["50"]["BorderSizePixel"] = 0;
				Tab["50"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Tab["50"]["ImageColor3"] = Color3.fromRGB(124, 124, 124);
				Tab["50"]["Image"] = options["Icon"];
				Tab["50"]["Size"] = UDim2.new(0, 23, 0, 23);
				Tab["50"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Tab["50"]["Name"] = [[Icon]];
				Tab["50"]["BackgroundTransparency"] = 1;
				Tab["50"]["Position"] = UDim2.new(0.3499999940395355, 0, 0.16300000250339508, 0);

				-- StarterGui.MyLibrary.MainBackground.Navigation.ButtonHolder.Active.Bar
				Tab["4d"] = Instance.new("Frame", Tab["4e"]);
				Tab["4d"]["BorderSizePixel"] = 0;
				Tab["4d"]["BackgroundTransparency"] = 1;
				Tab["4d"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
				Tab["4d"]["Size"] = UDim2.new(0, 2, 1, 0);
				Tab["4d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Tab["4d"]["Name"] = [[Bar]];
				
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab
				Tab["7"] = Instance.new("Frame", GUI["6"]);
				Tab["7"]["BorderSizePixel"] = 0;
				Tab["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Tab["7"]["BackgroundTransparency"] = 1;
				Tab["7"]["Size"] = UDim2.new(1, -12, 1, 2);
				Tab["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Tab["7"]["Position"] = UDim2.new(0, 6, 0, -14);
				Tab["7"]["Name"] = [[Tab]];
				Tab["7"]["Visible"] = false;
			end

			if options.PlayerList == false or options.SkinList == false then
				do -- Columns
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left
				Tab["8"] = Instance.new("Frame", Tab["7"]);
				Tab["8"]["BorderSizePixel"] = 0;
				Tab["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Tab["8"]["BackgroundTransparency"] = 1;
				Tab["8"]["Size"] = UDim2.new(0.495, 0, 1, 0);
				Tab["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Tab["8"]["Name"] = [[Left]];

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.UIListLayout
				Tab["9"] = Instance.new("UIListLayout", Tab["8"]);
				Tab["9"]["Padding"] = UDim.new(0, 10);
				Tab["9"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.UIPadding
				Tab["a"] = Instance.new("UIPadding", Tab["8"]);
				Tab["a"]["PaddingTop"] = UDim.new(0, 7);
				Tab["a"]["PaddingRight"] = UDim.new(0, 1);
				Tab["a"]["PaddingBottom"] = UDim.new(0, 1);
				Tab["a"]["PaddingLeft"] = UDim.new(0, 1);

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right
				Tab["41"] = Instance.new("Frame", Tab["7"]);
				Tab["41"]["BorderSizePixel"] = 0;
				Tab["41"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Tab["41"]["BackgroundTransparency"] = 1;
				Tab["41"]["Size"] = UDim2.new(0.495, 0, 1, 0);
				Tab["41"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Tab["41"]["Position"] = UDim2.new(0.505, 0, 0, 0);
				Tab["41"]["Name"] = [[Right]];

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.UIListLayout
				Tab["42"] = Instance.new("UIListLayout", Tab["41"]);
				Tab["42"]["Padding"] = UDim.new(0, 10);
				Tab["42"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.UIPadding
				Tab["43"] = Instance.new("UIPadding", Tab["41"]);
				Tab["43"]["PaddingTop"] = UDim.new(0, 7);
				Tab["43"]["PaddingRight"] = UDim.new(0, 1);
				Tab["43"]["PaddingBottom"] = UDim.new(0, 1);
				Tab["43"]["PaddingLeft"] = UDim.new(0, 1);
				end
			end
			-- Methods
			function Tab:Activate()
				if not Tab.Active then
					
					if GUI.CurrentTab ~= nil then
						GUI.CurrentTab:Deactivate()
					end
					
					Tab.Active = true
					
					Library:tween(Tab["4e"], {BackgroundColor3 = Color3.fromRGB(24, 27, 24)})
					Library:tween(Tab["4d"], {BackgroundTransparency = 0})
					Library:tween(Tab["50"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
					Library:tween(Tab["4f"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
					Tab["7"].Visible = true
					
					GUI.CurrentTab = Tab
				end
			end

			function Tab:Deactivate()
				if Tab.Active then
					Tab.Active = false
					Tab.Hover = false
					
					Library:tween(Tab["4e"], {BackgroundColor3 = Color3.fromRGB(24, 24, 24)})
					Library:tween(Tab["4d"], {BackgroundTransparency = 1})
					Library:tween(Tab["50"], {ImageColor3 = Color3.fromRGB(124, 124, 124)})
					Library:tween(Tab["4f"], {TextColor3 = Color3.fromRGB(124, 124, 124)})
					Tab["7"].Visible = false
				end
			end
			
			-- Logic
			do
				Tab["4e"].MouseEnter:Connect(function()
					Tab.Hover = true

					if not Tab.Active then
						Library:tween(Tab["50"], {ImageColor3 = Color3.fromRGB(214, 214, 214)})
						Library:tween(Tab["4f"], {TextColor3 = Color3.fromRGB(214, 214, 214)})
					end
				end)

				Tab["4e"].MouseLeave:Connect(function()
					Tab.Hover = false

					if not Tab.Active then
						Library:tween(Tab["50"], {ImageColor3 = Color3.fromRGB(124, 124, 124)})
						Library:tween(Tab["4f"], {TextColor3 = Color3.fromRGB(124, 124, 124)})
					end
				end)

				uis.InputBegan:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if Tab.Hover then
							Tab:Activate()
						end
					end
				end)

				if GUI.CurrentTab == nil then
					Tab:Activate()
				end
			end
			
		if options.PlayerList == true then
			
			local PlayerListTab = {
				Hover = false,
				Active = false,
				Scrolling = false,
				CurrentScroll = 0,
				test = false,
				test2 = false,
				CurrentPlayer = nil,
			}
			
			do -- Render
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab
				PlayerListTab["5"] = Instance.new("Frame", Tab["7"]);
				PlayerListTab["5"]["BorderSizePixel"] = 0;
				PlayerListTab["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["5"]["BackgroundTransparency"] = 1;
				PlayerListTab["5"]["Size"] = UDim2.new(1, -2, 1, 2);
				PlayerListTab["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["5"]["Position"] = UDim2.new(0, 1, 0, -14);
				PlayerListTab["5"]["Name"] = [[PlayerTab]];
				
				PlayerListTab["5a"] = Instance.new("UIPadding", PlayerListTab["5"]);
				PlayerListTab["5a"]["PaddingTop"] = UDim.new(0, 20);

				
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings
				PlayerListTab["6"] = Instance.new("Frame", PlayerListTab["5"]);
				PlayerListTab["6"]["BorderSizePixel"] = 0;
				PlayerListTab["6"]["BackgroundColor3"] = Color3.fromRGB(20, 20, 20);
				PlayerListTab["6"]["Size"] = UDim2.new(1, 0, -0.07653969526290894, 80);
				PlayerListTab["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["6"]["Position"] = UDim2.new(0, 0, 0.4911000430583954, 15);
				PlayerListTab["6"]["AutomaticSize"] = Enum.AutomaticSize.Y;
				PlayerListTab["6"]["Name"] = [[PlayerListSettings]];
				PlayerListTab["6"]["LayoutOrder"] = 2;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.UIStroke
				PlayerListTab["7"] = Instance.new("UIStroke", PlayerListTab["6"]);
				PlayerListTab["7"]["Color"] = Color3.fromRGB(27, 27, 27);

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.TopBar
				PlayerListTab["8"] = Instance.new("Frame", PlayerListTab["6"]);
				PlayerListTab["8"]["BorderSizePixel"] = 0;
				PlayerListTab["8"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
				PlayerListTab["8"]["Size"] = UDim2.new(1, 0, 0, 20);
				PlayerListTab["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["8"]["Name"] = [[TopBar]];

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.TopBar.Title
				PlayerListTab["9"] = Instance.new("TextLabel", PlayerListTab["8"]);
				PlayerListTab["9"]["BorderSizePixel"] = 0;
				PlayerListTab["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["9"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				PlayerListTab["9"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				PlayerListTab["9"]["TextSize"] = 14;
				PlayerListTab["9"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
				PlayerListTab["9"]["Size"] = UDim2.new(1, 0, 1, 0);
				PlayerListTab["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["9"]["Text"] = [[Player Name - Settings]];
				PlayerListTab["9"]["Name"] = [[Title]];
				PlayerListTab["9"]["BackgroundTransparency"] = 1;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.TopBar.Title.UIPadding
				PlayerListTab["a"] = Instance.new("UIPadding", PlayerListTab["9"]);
				PlayerListTab["a"]["PaddingLeft"] = UDim.new(0, 5);

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer
				PlayerListTab["c"] = Instance.new("Frame", PlayerListTab["6"]);
				PlayerListTab["c"]["BorderSizePixel"] = 0;
				PlayerListTab["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["c"]["BackgroundTransparency"] = 1;
				PlayerListTab["c"]["Size"] = UDim2.new(1, 0, 0.9620190262794495, -20);
				PlayerListTab["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["c"]["Position"] = UDim2.new(0, 0, 0, 20);
				PlayerListTab["c"]["AutomaticSize"] = Enum.AutomaticSize.Y;
				PlayerListTab["c"]["Name"] = [[ContentContainer]];

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.UIPadding
				PlayerListTab["d"] = Instance.new("UIPadding", PlayerListTab["c"]);
				PlayerListTab["d"]["PaddingTop"] = UDim.new(0, 10);
				PlayerListTab["d"]["PaddingBottom"] = UDim.new(0, -8);
				PlayerListTab["d"]["PaddingLeft"] = UDim.new(0, 10);
				
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.PlayerImage
				PlayerListTab["e"] = Instance.new("Frame", PlayerListTab["c"]);
				PlayerListTab["e"]["BorderSizePixel"] = 0;
				PlayerListTab["e"]["BackgroundColor3"] = Color3.fromRGB(23, 23, 23);
				PlayerListTab["e"]["Size"] = UDim2.new(0, 85, 0, 85);
				PlayerListTab["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["e"]["Name"] = [[PlayerImage]];

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.PlayerImage.UIStroke
				PlayerListTab["f"] = Instance.new("UIStroke", PlayerListTab["e"]);
				PlayerListTab["f"]["Color"] = Color3.fromRGB(27, 27, 27);

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.PlayerImage.Image
				PlayerListTab["10"] = Instance.new("ImageLabel", PlayerListTab["e"]);
				PlayerListTab["10"]["BorderSizePixel"] = 0;
				PlayerListTab["10"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["10"]["Size"] = UDim2.new(1, 0, 1, 0);
				PlayerListTab["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["10"]["Name"] = [[Image]];
				PlayerListTab["10"]["BackgroundTransparency"] = 1;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.PlayerImage.LoadingText
				PlayerListTab["11"] = Instance.new("TextLabel", PlayerListTab["e"]);
				PlayerListTab["11"]["BorderSizePixel"] = 0;
				PlayerListTab["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["11"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				PlayerListTab["11"]["TextSize"] = 20;
				PlayerListTab["11"]["TextColor3"] = Color3.fromRGB(215, 215, 215);
				PlayerListTab["11"]["Size"] = UDim2.new(1, 0, 1, 0);
				PlayerListTab["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["11"]["Text"] = [[. . ?]];
				PlayerListTab["11"]["Name"] = [[LoadingText]];
				PlayerListTab["11"]["BackgroundTransparency"] = 1;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.TextHolder
				PlayerListTab["12"] = Instance.new("Frame", PlayerListTab["c"]);
				PlayerListTab["12"]["BorderSizePixel"] = 0;
				PlayerListTab["12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["12"]["BackgroundTransparency"] = 1;
				PlayerListTab["12"]["Size"] = UDim2.new(0.5, -95, 0, 85);
				PlayerListTab["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["12"]["Position"] = UDim2.new(0, 95, 0, 0);
				PlayerListTab["12"]["Name"] = [[TextHolder]];

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.TextHolder.TextLabel
				PlayerListTab["13"] = Instance.new("TextLabel", PlayerListTab["12"]);
				PlayerListTab["13"]["BorderSizePixel"] = 0;
				PlayerListTab["13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["13"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				PlayerListTab["13"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				PlayerListTab["13"]["TextSize"] = 14;
				PlayerListTab["13"]["TextColor3"] = Color3.fromRGB(215, 215, 215);
				PlayerListTab["13"]["Size"] = UDim2.new(1, 0, 0, 20);
				PlayerListTab["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["13"]["Text"] = [[Health : 100/100]];
				PlayerListTab["13"]["BackgroundTransparency"] = 1;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.TextHolder.TextLabel.UIPadding
				PlayerListTab["14"] = Instance.new("UIPadding", PlayerListTab["13"]);


				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.TextHolder.UIListLayout
				PlayerListTab["15"] = Instance.new("UIListLayout", PlayerListTab["12"]);
				PlayerListTab["15"]["Padding"] = UDim.new(0, 4);
				PlayerListTab["15"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
				
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.UIPadding
				PlayerListTab["2c"] = Instance.new("UIPadding", PlayerListTab["12"]);
				PlayerListTab["2c"]["PaddingTop"] = UDim.new(0, 1);

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.TextHolder.UserId
				PlayerListTab["16"] = Instance.new("TextLabel", PlayerListTab["12"]);
				PlayerListTab["16"]["BorderSizePixel"] = 0;
				PlayerListTab["16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["16"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				PlayerListTab["16"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				PlayerListTab["16"]["TextSize"] = 14;
				PlayerListTab["16"]["TextColor3"] = Color3.fromRGB(215, 215, 215);
				PlayerListTab["16"]["Size"] = UDim2.new(1, 0, 0, 20);
				PlayerListTab["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["16"]["Text"] = "UserID : 1";
				PlayerListTab["16"]["Name"] = [[UserId]];
				PlayerListTab["16"]["BackgroundTransparency"] = 1;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.TextHolder.UserId.UIPadding
				PlayerListTab["17"] = Instance.new("UIPadding", PlayerListTab["16"]);


				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.TextHolder.TextLabel
				PlayerListTab["18"] = Instance.new("TextLabel", PlayerListTab["12"]);
				PlayerListTab["18"]["BorderSizePixel"] = 0;
				PlayerListTab["18"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["18"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				PlayerListTab["18"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				PlayerListTab["18"]["TextSize"] = 14;
				PlayerListTab["18"]["TextColor3"] = Color3.fromRGB(215, 215, 215);
				PlayerListTab["18"]["Size"] = UDim2.new(1, 0, 0, 20);
				PlayerListTab["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["18"]["Text"] = "Display Name : Unknown";
				PlayerListTab["18"]["BackgroundTransparency"] = 1;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.TextHolder.TextLabel.UIPadding
				PlayerListTab["19"] = Instance.new("UIPadding", PlayerListTab["18"]);


				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.TextHolder.TextLabel
				PlayerListTab["1a"] = Instance.new("TextLabel", PlayerListTab["12"]);
				PlayerListTab["1a"]["BorderSizePixel"] = 0;
				PlayerListTab["1a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["1a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				PlayerListTab["1a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				PlayerListTab["1a"]["TextSize"] = 14;
				PlayerListTab["1a"]["TextColor3"] = Color3.fromRGB(215, 215, 215);
				PlayerListTab["1a"]["Size"] = UDim2.new(1, 0, 0, 20);
				PlayerListTab["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["1a"]["Text"] = "Name : Unknown";
				PlayerListTab["1a"]["BackgroundTransparency"] = 1;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.TextHolder.TextLabel.UIPadding
				PlayerListTab["1b"] = Instance.new("UIPadding", PlayerListTab["1a"]);

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.ContentContainer.DropdownHolder
				PlayerListTab["1c"] = Instance.new("Frame", PlayerListTab["c"]);
				PlayerListTab["1c"]["BorderSizePixel"] = 0;
				PlayerListTab["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["1c"]["AnchorPoint"] = Vector2.new(1, 0);
				PlayerListTab["1c"]["BackgroundTransparency"] = 1;
				PlayerListTab["1c"]["Size"] = UDim2.new(0.5, -10, 0, 85);
				PlayerListTab["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["1c"]["Position"] = UDim2.new(1, -10, 0, 0);
				PlayerListTab["1c"]["Name"] = [[DropdownHolder]];

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.UIListLayout
				PlayerListTab["1d"] = Instance.new("UIListLayout", PlayerListTab["5"]);
				PlayerListTab["1d"]["Padding"] = UDim.new(0, 10);
				PlayerListTab["1d"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection
				PlayerListTab["1e"] = Instance.new("Frame", PlayerListTab["5"]);
				PlayerListTab["1e"]["BorderSizePixel"] = 0;
				PlayerListTab["1e"]["BackgroundColor3"] = Color3.fromRGB(20, 20, 20);
				PlayerListTab["1e"]["Size"] = UDim2.new(1, 0, 0.77, 0);
				PlayerListTab["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["1e"]["Name"] = [[PlayerListSection]];
				PlayerListTab["1e"]["LayoutOrder"] = 1;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.TopBar
				PlayerListTab["1f"] = Instance.new("Frame", PlayerListTab["1e"]);
				PlayerListTab["1f"]["BorderSizePixel"] = 0;
				PlayerListTab["1f"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
				PlayerListTab["1f"]["Size"] = UDim2.new(1, 0, 0, 20);
				PlayerListTab["1f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["1f"]["Name"] = [[TopBar]];

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.TopBar.Title
				PlayerListTab["20"] = Instance.new("TextLabel", PlayerListTab["1f"]);
				PlayerListTab["20"]["BorderSizePixel"] = 0;
				PlayerListTab["20"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["20"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				PlayerListTab["20"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				PlayerListTab["20"]["TextSize"] = 14;
				PlayerListTab["20"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
				PlayerListTab["20"]["Size"] = UDim2.new(1, 0, 1, 0);
				PlayerListTab["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["20"]["Text"] = "Player List - 32 Players";
				PlayerListTab["20"]["Name"] = [[Title]];
				PlayerListTab["20"]["BackgroundTransparency"] = 1;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.TopBar.Title.UIPadding
				PlayerListTab["21"] = Instance.new("UIPadding", PlayerListTab["20"]);
				PlayerListTab["21"]["PaddingLeft"] = UDim.new(0, 5);

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList
				PlayerListTab["23"] = Instance.new("Frame", PlayerListTab["1e"]);
				PlayerListTab["23"]["BorderSizePixel"] = 0;
				PlayerListTab["23"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["23"]["BackgroundTransparency"] = 1;
				PlayerListTab["23"]["Size"] = UDim2.new(1, 0, 1, -20);
				PlayerListTab["23"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["23"]["Position"] = UDim2.new(0, 0, 0, 20);
				PlayerListTab["23"]["Name"] = [[PlayerList]];
				PlayerListTab["23"]["ClipsDescendants"] = true;
				
				PlayerListTab["5g"] = Instance.new("UIPadding", PlayerListTab["23"]);
				PlayerListTab["5g"]["PaddingTop"] = UDim.new(0, 1);

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.UIStroke
				PlayerListTab["2b"] = Instance.new("UIStroke", PlayerListTab["1e"]);
				PlayerListTab["2b"]["Color"] = Color3.fromRGB(27, 27, 27);
				
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.ScrollBarBack
				PlayerListTab["2b"] = Instance.new("Frame", PlayerListTab["1e"]);
				PlayerListTab["2b"]["BorderSizePixel"] = 0;
				PlayerListTab["2b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["2b"]["AnchorPoint"] = Vector2.new(1, 0);
				PlayerListTab["2b"]["BackgroundTransparency"] = 1;
				PlayerListTab["2b"]["Size"] = UDim2.new(0, 6, 1, -19);
				PlayerListTab["2b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["2b"]["Position"] = UDim2.new(1, -1, 0, 19);
				PlayerListTab["2b"]["Name"] = [[ScrollBarBack]];

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.ScrollBarBack.ScrollBar
				PlayerListTab["2c"] = Instance.new("Frame", PlayerListTab["2b"]);
				PlayerListTab["2c"]["BorderSizePixel"] = 0;
				PlayerListTab["2c"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
				PlayerListTab["2c"]["Size"] = UDim2.new(1, 0, 0.6000000238418579, 0);
				PlayerListTab["2c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["2c"]["Name"] = [[ScrollBar]];
				
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder
				PlayerListTab["24"] = Instance.new("Frame", PlayerListTab["23"]);
				PlayerListTab["24"]["BorderSizePixel"] = 0;
				PlayerListTab["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["24"]["BackgroundTransparency"] = 1;
				PlayerListTab["24"]["Size"] = UDim2.new(1, 0, 1, 0);
				PlayerListTab["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["24"]["Name"] = [[Holder]];

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.UIListLayout
				PlayerListTab["2f"] = Instance.new("UIListLayout", PlayerListTab["24"]);
				PlayerListTab["2f"]["Padding"] = UDim.new(0, 2);
				PlayerListTab["2f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
			end
			
			do -- Methods
				function PlayerListTab:RemnovePlayer(Player)
					for Index, Value in pairs(PlayerListTab["24"]:GetDescendants()) do
						if Value.Name == Player.Name then
							Value:Destroy()
						end
					end
				end

				function PlayerListTab:UpdateTexts()
					if PlayerListTab.CurrentPlayer ~= nil then
						local TargetPlayer = PlayerListTab.CurrentPlayer ~= nil and players:FindFirstChild(PlayerListTab.CurrentPlayer["25"].Name)
						local Humanoid = TargetPlayer.Character:FindFirstChild("Humanoid")

						PlayerListTab["9"].Text = string.format("[%s] - Settings", TargetPlayer.Name)
						PlayerListTab["16"].Text = string.format("UserID : %s", TargetPlayer.UserId)
						PlayerListTab["18"].Text = string.format("Name : %s", TargetPlayer.Name)
						PlayerListTab["1a"].Text = string.format("Display Name : %s", TargetPlayer.DisplayName)
						PlayerListTab["13"].Text = string.format("Health : %s/%s", math.floor(Humanoid.Health), math.floor(Humanoid.MaxHealth))
						PlayerListTab["11"].Visible = false
						PlayerListTab["10"].Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%s&width=420&height=420&format=png", TargetPlayer.UserId)
					else
						PlayerListTab["9"].Text = "[Unknown Player] - Settings"
						PlayerListTab["16"].Text = "User ID: Unknown"
						PlayerListTab["18"].Text = "Name : Unknown"
						PlayerListTab["1a"].Text = "Display Name : Unknown"
						PlayerListTab["11"].Visible = true
						PlayerListTab["10"].Image = ""
					end
				end
				
				function PlayerListTab:AddPlayer(Player)

					local Item = {
						Hover = false,
						MouseDown = false,
					}

					if Player == players.LocalPlayer then
						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.PlayerFrame
						Item["25"] = Instance.new("Frame", PlayerListTab["24"]);
						Item["25"]["BorderSizePixel"] = 0;
						Item["25"]["BackgroundColor3"] = Color3.fromRGB(18, 18, 18);
						Item["25"]["Size"] = UDim2.new(1, -9, 0, 24);
						Item["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["25"]["Name"] = Player.Name;
						Item["25"]["LayoutOrder"] = 1;

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.PlayerFrame.PlayerName
						Item["26"] = Instance.new("TextLabel", Item["25"]);
						Item["26"]["BorderSizePixel"] = 0;
						Item["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["26"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Item["26"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Item["26"]["TextSize"] = 16;
						Item["26"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
						Item["26"]["Size"] = UDim2.new(0.33000001311302185, 0, 1, 0);
						Item["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["26"]["Text"] = Player.Name;
						Item["26"]["Name"] = [[PlayerName]];
						Item["26"]["BackgroundTransparency"] = 1;

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.PlayerFrame.PlayerName.UIPadding
						Item["27"] = Instance.new("UIPadding", Item["26"]);
						Item["27"]["PaddingLeft"] = UDim.new(0, 10);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.PlayerFrame.Team
						Item["28"] = Instance.new("TextLabel", Item["25"]);
						Item["28"]["BorderSizePixel"] = 0;
						Item["28"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["28"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Item["28"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Item["28"]["TextSize"] = 16;
						Item["28"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
						Item["28"]["Size"] = UDim2.new(0.33000001311302185, 0, 1, 0);
						Item["28"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["28"]["Text"] = Player.Team ~= nil and Player.Team or "Neutral";
						Item["28"]["Name"] = [[Team]];
						Item["28"]["BackgroundTransparency"] = 1;
						Item["28"]["Position"] = UDim2.new(0.33000001311302185, 0, 0, 0);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.PlayerFrame.Flags
						Item["29"] = Instance.new("TextLabel", Item["25"]);
						Item["29"]["BorderSizePixel"] = 0;
						Item["29"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["29"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Item["29"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Item["29"]["TextSize"] = 16;
						Item["29"]["TextColor3"] = Color3.fromRGB(255, 0, 255);
						Item["29"]["Size"] = UDim2.new(0.33000001311302185, 0, 1, 0);
						Item["29"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["29"]["Text"] = [[Local Player]];
						Item["29"]["Name"] = [[Flags]];
						Item["29"]["BackgroundTransparency"] = 1;
						Item["29"]["Position"] = UDim2.new(0.6600000262260437, 0, 0, 0);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.PlayerFrame.UIStroke
						Item["2a"] = Instance.new("UIStroke", Item["25"]);
						Item["2a"]["Color"] = Color3.fromRGB(31, 31, 31);
					else
						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.PlayerFrame
						Item["25"] = Instance.new("Frame", PlayerListTab["24"]);
						Item["25"]["BorderSizePixel"] = 0;
						Item["25"]["BackgroundColor3"] = Color3.fromRGB(18, 18, 18);
						Item["25"]["Size"] = UDim2.new(1, -8, 0, 24);
						Item["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["25"]["Name"] = Player.Name;
						Item["25"]["LayoutOrder"] = 2;

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.PlayerFrame.PlayerName
						Item["26"] = Instance.new("TextLabel", Item["25"]);
						Item["26"]["BorderSizePixel"] = 0;
						Item["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["26"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Item["26"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Item["26"]["TextSize"] = 16;
						Item["26"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
						Item["26"]["Size"] = UDim2.new(0.33000001311302185, 0, 1, 0);
						Item["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["26"]["Text"] = Player.Name;
						Item["26"]["Name"] = [[PlayerName]];
						Item["26"]["BackgroundTransparency"] = 1;

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.PlayerFrame.PlayerName.UIPadding
						Item["27"] = Instance.new("UIPadding", Item["26"]);
						Item["27"]["PaddingLeft"] = UDim.new(0, 10);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.PlayerFrame.Team
						Item["28"] = Instance.new("TextLabel", Item["25"]);
						Item["28"]["BorderSizePixel"] = 0;
						Item["28"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["28"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Item["28"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Item["28"]["TextSize"] = 16;
						Item["28"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
						Item["28"]["Size"] = UDim2.new(0.33000001311302185, 0, 1, 0);
						Item["28"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["28"]["Text"] = Player.Team ~= nil and Player.Team or "Neutral";
						Item["28"]["Name"] = [[Team]];
						Item["28"]["BackgroundTransparency"] = 1;
						Item["28"]["Position"] = UDim2.new(0.33000001311302185, 0, 0, 0);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.PlayerFrame.Flags
						Item["29"] = Instance.new("TextLabel", Item["25"]);
						Item["29"]["BorderSizePixel"] = 0;
						Item["29"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["29"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Item["29"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Item["29"]["TextSize"] = 16;
						Item["29"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
						Item["29"]["Size"] = UDim2.new(0.33000001311302185, 0, 1, 0);
						Item["29"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["29"]["Text"] = "None";
						Item["29"]["Name"] = [[Flags]];
						Item["29"]["BackgroundTransparency"] = 1;
						Item["29"]["Position"] = UDim2.new(0.6600000262260437, 0, 0, 0);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.Holder.PlayerFrame.UIStroke
						Item["2a"] = Instance.new("UIStroke", Item["25"]);
						Item["2a"]["Color"] = Color3.fromRGB(31, 31, 31);
					end
					
					function Item:Activate()
						if not Item.Active then

							if PlayerListTab.CurrentPlayer ~= nil then
								PlayerListTab.CurrentPlayer:Deactivate()
							end

							Item.Active = true

							Library:tween(Item["26"], {TextColor3 = Color3.fromRGB(0, 255, 0)})

							PlayerListTab.CurrentPlayer = Item

							PlayerListTab:UpdateTexts()
						end
					end

					function Item:Deactivate()
						if Item.Active then
							Item.Active = false
							Item.Hover = false

							Library:tween(Item["26"], {TextColor3 = Color3.fromRGB(214, 214, 214)})
						end
					end

					Item["25"].MouseEnter:Connect(function()
						Item.Hover = true
						if not Item.Active then
							Library:tween(Item["26"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
						end
					end)

					Item["25"].MouseLeave:Connect(function()
						Item.Hover = false

						if not Item.Active then
							Library:tween(Item["26"], {TextColor3 = Color3.fromRGB(214, 214, 214)})
						end
					end)

					uis.InputBegan:Connect(function(input, gpe)
						if gpe then return end

						if input.UserInputType == Enum.UserInputType.MouseButton1 and Item.Hover then
							Item:Activate()
						end
					end)
				end
				
				function PlayerListTab:UpdatePlayerNumber()
					PlayerListTab["20"].Text = string.format("Player List - %s Players", #players:GetPlayers())
				end
			end

			-- Logic
			do
				for _, Player in pairs(players:GetPlayers()) do
					PlayerListTab:AddPlayer(Player)
				end

				players.PlayerAdded:Connect(function(Player)
					PlayerListTab:AddPlayer(Player)
					PlayerListTab:UpdatePlayerNumber()
				end)

				players.PlayerRemoving:Connect(function(Player)
					PlayerListTab:RemnovePlayer(Player)
					PlayerListTab:UpdatePlayerNumber()
				end)
				
				
				PlayerListTab["23"].MouseEnter:Connect(function()
					PlayerListTab.test = true
					game:GetService("ContextActionService"):BindAction("disable_mouse_input", function()
						return Enum.ContextActionResult.Sink
					end, false, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3, Enum.UserInputType.MouseWheel)
				end)

				PlayerListTab["23"].MouseLeave:Connect(function()
					PlayerListTab.test = false
					game:GetService("ContextActionService"):UnbindAction("disable_mouse_input")
				end)
				
				PlayerListTab["2b"].MouseEnter:Connect(function()
					PlayerListTab.test2 = true
				end)

				PlayerListTab["2b"].MouseLeave:Connect(function()
					PlayerListTab.test2 = false
				end)
				
				do
					local tile_size = 24
					local max_players = 40.6
					local max_bars = math.floor((PlayerListTab["23"].AbsoluteSize.Y + 94) / (tile_size + 4))
					max_players = max_players - max_bars
					
					local function scroll(amount)
						PlayerListTab.CurrentScroll = math.clamp(amount, 0, max_players)

						if PlayerListTab.CurrentScroll > 0 then
							PlayerListTab["24"].Position = UDim2.new(0, 0, 0, PlayerListTab.CurrentScroll * -tile_size - ((PlayerListTab.CurrentScroll) * 4) + 28)
						else
							PlayerListTab["24"].Position = UDim2.new(0, 0, 0, 0)
						end

						PlayerListTab["2c"].Position = UDim2.new(0, 0, (1 / (max_players + 35)) * PlayerListTab.CurrentScroll)
					end

					local function update_scroll(input)
						local sizeY = math.clamp((input.Position.Y - PlayerListTab["2b"].AbsolutePosition.Y - game:GetService("GuiService"):GetGuiInset().Y) / PlayerListTab["2b"].AbsoluteSize.Y, 0, 1)
						local value = math.round(math.clamp(max_players * sizeY, 0, max_players))

						scroll(value)
					end
					
					uis.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if PlayerListTab.test2 then
								PlayerListTab.Scrolling = true
								update_scroll{Position = uis:GetMouseLocation() - Vector2.new(0, 36)}
							end
						end
					end)

					uis.InputChanged:Connect(function(input)
						if PlayerListTab.Scrolling and input.UserInputType == Enum.UserInputType.MouseMovement then
							update_scroll(input)
						end
					end)

					uis.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							PlayerListTab.Scrolling = false
						end
					end)

					PlayerListTab["23"].InputChanged:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseWheel then
							if input.Position.Z > 0 then
								scroll(PlayerListTab.CurrentScroll - 1)
							else
								scroll(PlayerListTab.CurrentScroll + 1)
							end
						end
					end)
				end

				PlayerListTab:UpdateTexts()
			end
			
			return PlayerListTab
		end
		
		if options.SkinList == true then
			
			local SkinList = {
				CurrentGun = nil,
				CurrentSkin = nil,
			}
			
			do -- Methods
				function SkinList:GunsList()
					local GunListTab = {
						Hover = false,
						Active = false,
						Scrolling = false,
						CurrentScroll = 0,
						test = false,
						test2 = false,
						AmountOfGuns = 0,
					}

					do -- Render
						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab
						GunListTab["1d"] = Instance.new("Frame", Tab["7"]);
						GunListTab["1d"]["BorderSizePixel"] = 0;
						GunListTab["1d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						GunListTab["1d"]["BackgroundTransparency"] = 1;
						GunListTab["1d"]["Size"] = UDim2.new(1, -2, 1, 14);
						GunListTab["1d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						GunListTab["1d"]["Position"] = UDim2.new(0, 1, 0, -14);
						GunListTab["1d"]["Name"] = [[GunsTab]];
						GunListTab["1d"]["ZIndex"] = 2;

						GunListTab["1i"] = Instance.new("UIPadding", GunListTab["1d"]);
						GunListTab["1i"]["PaddingTop"] = UDim.new(0, 20);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.UIListLayout
						GunListTab["1e"] = Instance.new("UIListLayout", GunListTab["1d"]);
						GunListTab["1e"]["Padding"] = UDim.new(0, 10);
						GunListTab["1e"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection
						GunListTab["1f"] = Instance.new("Frame", GunListTab["1d"]);
						GunListTab["1f"]["BorderSizePixel"] = 0;
						GunListTab["1f"]["BackgroundColor3"] = Color3.fromRGB(20, 20, 20);
						GunListTab["1f"]["LayoutOrder"] = 1;
						GunListTab["1f"]["Size"] = UDim2.new(1, 0, 1.0072979927062988, 0);
						GunListTab["1f"]["ClipsDescendants"] = true;
						GunListTab["1f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						GunListTab["1f"]["Name"] = [[SkinListSection]];

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.TopBar
						GunListTab["20"] = Instance.new("Frame", GunListTab["1f"]);
						GunListTab["20"]["BorderSizePixel"] = 0;
						GunListTab["20"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
						GunListTab["20"]["Size"] = UDim2.new(1, 0, 0, 20);
						GunListTab["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						GunListTab["20"]["Name"] = [[TopBar]];

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.TopBar.Title
						GunListTab["21"] = Instance.new("TextLabel", GunListTab["20"]);
						GunListTab["21"]["BorderSizePixel"] = 0;
						GunListTab["21"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						GunListTab["21"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						GunListTab["21"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						GunListTab["21"]["TextSize"] = 14;
						GunListTab["21"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
						GunListTab["21"]["Size"] = UDim2.new(1, 0, 1, 0);
						GunListTab["21"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						GunListTab["21"]["Text"] = [[Gun List - Unknown]];
						GunListTab["21"]["Name"] = [[Title]];
						GunListTab["21"]["BackgroundTransparency"] = 1;

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.TopBar.Title.UIPadding
						GunListTab["22"] = Instance.new("UIPadding", GunListTab["21"]);
						GunListTab["22"]["PaddingLeft"] = UDim.new(0, 5);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList
						GunListTab["23"] = Instance.new("Frame", GunListTab["1f"]);
						GunListTab["23"]["BorderSizePixel"] = 0;
						GunListTab["23"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						GunListTab["23"]["BackgroundTransparency"] = 1;
						GunListTab["23"]["Size"] = UDim2.new(1, 0, 1, -20);
						GunListTab["23"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						GunListTab["23"]["Position"] = UDim2.new(0, 0, 0, 20);
						GunListTab["23"]["Name"] = [[SkinList]];

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder
						GunListTab["24"] = Instance.new("Frame", GunListTab["23"]);
						GunListTab["24"]["BorderSizePixel"] = 0;
						GunListTab["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						GunListTab["24"]["BackgroundTransparency"] = 1;
						GunListTab["24"]["Size"] = UDim2.new(1, 0, 1, 0);
						GunListTab["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						GunListTab["24"]["Name"] = [[Holder]];

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.UIPadding
						GunListTab["2e"] = Instance.new("UIPadding", GunListTab["24"]);
						GunListTab["2e"]["PaddingTop"] = UDim.new(0, 5);
						GunListTab["2e"]["PaddingLeft"] = UDim.new(0, -7);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.UIGridLayout
						GunListTab["2f"] = Instance.new("UIGridLayout", GunListTab["24"]);
						GunListTab["2f"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
						GunListTab["2f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
						GunListTab["2f"]["FillDirectionMaxCells"] = 5;
						GunListTab["2f"]["CellSize"] = UDim2.new(0, 120, 0, 120);
						GunListTab["2f"]["CellPadding"] = UDim2.new(0, 10, 0, 10);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.UIStroke
						GunListTab["30"] = Instance.new("UIStroke", GunListTab["1f"]);
						GunListTab["30"]["Color"] = Color3.fromRGB(27, 27, 27);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.ScrollBarBack
						GunListTab["31"] = Instance.new("Frame", GunListTab["1f"]);
						GunListTab["31"]["BorderSizePixel"] = 0;
						GunListTab["31"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						GunListTab["31"]["AnchorPoint"] = Vector2.new(1, 0);
						GunListTab["31"]["BackgroundTransparency"] = 1;
						GunListTab["31"]["Size"] = UDim2.new(0, 6, 1, -19);
						GunListTab["31"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						GunListTab["31"]["Position"] = UDim2.new(1, -1, 0, 19);
						GunListTab["31"]["Name"] = [[ScrollBarBack]];

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.ScrollBarBack.ScrollBar
						GunListTab["32"] = Instance.new("Frame", GunListTab["31"]);
						GunListTab["32"]["BorderSizePixel"] = 0;
						GunListTab["32"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
						GunListTab["32"]["Size"] = UDim2.new(1, 0, 0.5, 0);
						GunListTab["32"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						GunListTab["32"]["Name"] = [[ScrollBar]];
					end

					do -- Methods
						function GunListTab:UpdateTexts()
							GunListTab["21"].Text = string.format("Gun List - %s Guns", tostring(GunListTab.AmountOfGuns))
						end

						function GunListTab:RemoveGun(gun)
							for Index, Value in pairs(GunListTab["24"]:GetDescendants()) do
								if Value.Name == gun.Name then
									Value:Destroy()
								end
							end
						end

						function GunListTab:AddGun(name, icon)
							local Item = {
								Hover = false,
								MouseDown = false,
							}

							GunListTab.AmountOfGuns += 1

							do -- Render
								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame
								Item["25"] = Instance.new("Frame", GunListTab["24"]);
								Item["25"]["BorderSizePixel"] = 0;
								Item["25"]["BackgroundColor3"] = Color3.fromRGB(16, 16, 16);
								Item["25"]["Size"] = UDim2.new(0, 100, 0, 100);
								Item["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
								Item["25"]["Name"] = name;

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.SkinName
								Item["26"] = Instance.new("TextLabel", Item["25"]);
								Item["26"]["BorderSizePixel"] = 0;
								Item["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
								Item["26"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
								Item["26"]["TextSize"] = 16;
								Item["26"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
								Item["26"]["AnchorPoint"] = Vector2.new(0, 1);
								Item["26"]["Size"] = UDim2.new(1, 0, 0, 20);
								Item["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
								Item["26"]["Text"] = name ~= nil and name or "N/A";
								Item["26"]["Name"] = [[SkinName]];
								Item["26"]["BackgroundTransparency"] = 1;
								Item["26"]["Position"] = UDim2.new(0, 0, 1, 0);

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.SkinName.UIPadding
								Item["27"] = Instance.new("UIPadding", Item["26"]);
								Item["27"]["PaddingBottom"] = UDim.new(0, 15);

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.UIStroke
								Item["28"] = Instance.new("UIStroke", Item["25"]);
								Item["28"]["Color"] = Color3.fromRGB(31, 31, 31);

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.GunName
								Item["29"] = Instance.new("TextLabel", Item["25"]);
								Item["29"]["BorderSizePixel"] = 0;
								Item["29"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
								Item["29"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
								Item["29"]["TextSize"] = 13;
								Item["29"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
								Item["29"]["TextTransparency"] = 1;
								Item["29"]["AnchorPoint"] = Vector2.new(0, 1);
								Item["29"]["Size"] = UDim2.new(1, 0, 0, 20);
								Item["29"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
								Item["29"]["Text"] = [[N/A]];
								Item["29"]["Name"] = [[GunName]];
								Item["29"]["BackgroundTransparency"] = 1;
								Item["29"]["Position"] = UDim2.new(0, 0, 1, -15);

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.GunName.UIPadding
								Item["2a"] = Instance.new("UIPadding", Item["29"]);
								Item["2a"]["PaddingBottom"] = UDim.new(0, 5);

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.ImageHolder
								Item["2b"] = Instance.new("Frame", Item["25"]);
								Item["2b"]["BorderSizePixel"] = 0;
								Item["2b"]["BackgroundColor3"] = Color3.fromRGB(21, 21, 21);
								Item["2b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
								Item["2b"]["Size"] = UDim2.new(1, -15, 1, -40);
								Item["2b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
								Item["2b"]["Position"] = UDim2.new(0.5, 0, 0.5, -15);
								Item["2b"]["Name"] = [[ImageHolder]];

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.ImageHolder.Image
								Item["2c"] = Instance.new("ImageLabel", Item["2b"]);
								Item["2c"]["BorderSizePixel"] = 0;
								Item["2c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
								Item["2c"]["AnchorPoint"] = Vector2.new(0.5, 0);
								Item["2c"]["Size"] = UDim2.new(1, 0, 1, 0);
								Item["2c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
								Item["2c"]["Name"] = [[Image]];
								Item["2c"]["Image"] = icon ~= nil and icon or "";
								Item["2c"]["BackgroundTransparency"] = 1;
								Item["2c"]["Position"] = UDim2.new(0.5, 0, 0, 0);

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.ImageHolder.UIStroke
								Item["2d"] = Instance.new("UIStroke", Item["2b"]);
								Item["2d"]["Color"] = Color3.fromRGB(27, 27, 27);
							end

							do -- Methods
								function Item:Activate()
									if not Item.Active then

										if SkinList.CurrentGun ~= nil then
											SkinList.CurrentGun:Deactivate()
										end

										Item.Active = true
										
										SkinList.CurrentGun = Item
										task.delay(0.1, function()
											if SkinList.CurrentGun ~= nil then
												SkinList.CurrentGun["25"].Parent.Parent.Parent.Parent.Visible = false
											end
										end)
									end
								end

								function Item:Deactivate()
									if Item.Active then
										Item.Active = false
										Item.Hover = false
									end
								end
							end

							Item["25"].MouseEnter:Connect(function()
								Item.Hover = true
								if not Item.Active then
									Library:tween(Item["28"], {Color = Color3.fromRGB(55, 55, 55)})
									Library:tween(Item["2d"], {Color = Color3.fromRGB(40, 40, 40)})
								end
							end)

							Item["25"].MouseLeave:Connect(function()
								Item.Hover = false

								if not Item.Active then
									Library:tween(Item["28"], {Color = Color3.fromRGB(30, 30, 30)})
									Library:tween(Item["2d"], {Color = Color3.fromRGB(30, 30, 30)})
								end
							end)

							uis.InputBegan:Connect(function(input, gpe)
								if gpe then return end

								if input.UserInputType == Enum.UserInputType.MouseButton1 and Item.Hover then
									Item:Activate()
								end
							end)

							uis.InputEnded:Connect(function(input, gpe)
								if gpe then return end

								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									Item.MouseDown = false

									if Item.Hover then
										Library:tween(Item["28"], {Color = Color3.fromRGB(55, 55, 55)})
										Library:tween(Item["2d"], {Color = Color3.fromRGB(40, 40, 40)})
									else
										Library:tween(Item["28"], {Color = Color3.fromRGB(30, 30, 30)})
										Library:tween(Item["2d"], {Color = Color3.fromRGB(30, 30, 30)})
									end
								end
							end)

							GunListTab:UpdateTexts()
						end

						do -- Logic
							GunListTab["23"].MouseEnter:Connect(function()
								GunListTab.test = true
								game:GetService("ContextActionService"):BindAction("disable_mouse_input", function()
									return Enum.ContextActionResult.Sink
								end, false, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3, Enum.UserInputType.MouseWheel)
							end)

							GunListTab["23"].MouseLeave:Connect(function()
								GunListTab.test = false
								game:GetService("ContextActionService"):UnbindAction("disable_mouse_input")
							end)

							GunListTab["31"].MouseEnter:Connect(function()
								GunListTab.test2 = true
							end)

							GunListTab["31"].MouseLeave:Connect(function()
								GunListTab.test2 = false
							end)

							do
								local tile_size = 24
								local max_players = 40.6
								local max_bars = math.floor((GunListTab["23"].AbsoluteSize.Y + 94) / (tile_size + 4))
								max_players = max_players - max_bars

								local function scroll(amount)
									GunListTab.CurrentScroll = math.clamp(amount, 0, max_players)

									if GunListTab.CurrentScroll > 0 then
										GunListTab["24"].Position = UDim2.new(0, 0, 0, GunListTab.CurrentScroll * -tile_size - ((GunListTab.CurrentScroll) * 4) + 12)
									else
										GunListTab["24"].Position = UDim2.new(0, 0, 0, 0)
									end

									GunListTab["32"].Position = UDim2.new(0, 0, (1 / (max_players + 19)) * GunListTab.CurrentScroll)
								end

								local function update_scroll(input)
									local sizeY = math.clamp((input.Position.Y - GunListTab["31"].AbsolutePosition.Y - game:GetService("GuiService"):GetGuiInset().Y) / GunListTab["31"].AbsoluteSize.Y, 0, 1)
									local value = math.round(math.clamp(max_players * sizeY, 0, max_players))

									scroll(value)
								end

								uis.InputBegan:Connect(function(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 then
										if GunListTab.test2 then
											GunListTab.Scrolling = true
											update_scroll{Position = uis:GetMouseLocation() - Vector2.new(0, 36)}
										end
									end
								end)

								uis.InputChanged:Connect(function(input)
									if GunListTab.Scrolling and input.UserInputType == Enum.UserInputType.MouseMovement then
										update_scroll(input)
									end
								end)

								uis.InputEnded:Connect(function(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 then
										GunListTab.Scrolling = false
									end
								end)

								GunListTab["23"].InputChanged:Connect(function(input)
									if input.UserInputType == Enum.UserInputType.MouseWheel then
										if input.Position.Z > 0 then
											scroll(GunListTab.CurrentScroll - 1)
										else
											scroll(GunListTab.CurrentScroll + 1)
										end
									end
								end)
							end
						end
					end
					
					return GunListTab
				end
				
				function SkinList:SkinsList()
					local SkinListTab = {
						Hover = false,
						Active = false,
						Scrolling = false,
						CurrentScroll = 0,
						test = false,
						test2 = false,
						CurrentSkin = nil,
						AmountOfSkins = 0,
					}

					do -- Render
						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab
						SkinListTab["1d"] = Instance.new("Frame", Tab["7"]);
						SkinListTab["1d"]["BorderSizePixel"] = 0;
						SkinListTab["1d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						SkinListTab["1d"]["BackgroundTransparency"] = 1;
						SkinListTab["1d"]["Size"] = UDim2.new(1, -2, 1, 14);
						SkinListTab["1d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						SkinListTab["1d"]["Position"] = UDim2.new(0, 1, 0, -14);
						SkinListTab["1d"]["Name"] = [[SkinsTab]];

						SkinListTab["1i"] = Instance.new("UIPadding", SkinListTab["1d"]);
						SkinListTab["1i"]["PaddingTop"] = UDim.new(0, 20);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.UIListLayout
						SkinListTab["1e"] = Instance.new("UIListLayout", SkinListTab["1d"]);
						SkinListTab["1e"]["Padding"] = UDim.new(0, 10);
						SkinListTab["1e"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection
						SkinListTab["1f"] = Instance.new("Frame", SkinListTab["1d"]);
						SkinListTab["1f"]["BorderSizePixel"] = 0;
						SkinListTab["1f"]["BackgroundColor3"] = Color3.fromRGB(20, 20, 20);
						SkinListTab["1f"]["LayoutOrder"] = 1;
						SkinListTab["1f"]["Size"] = UDim2.new(1, 0, 1.0072979927062988, 0);
						SkinListTab["1f"]["ClipsDescendants"] = true;
						SkinListTab["1f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						SkinListTab["1f"]["Name"] = [[SkinListSection]];

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.TopBar
						SkinListTab["20"] = Instance.new("Frame", SkinListTab["1f"]);
						SkinListTab["20"]["BorderSizePixel"] = 0;
						SkinListTab["20"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
						SkinListTab["20"]["Size"] = UDim2.new(1, 0, 0, 20);
						SkinListTab["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						SkinListTab["20"]["Name"] = [[TopBar]];

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.TopBar.Title
						SkinListTab["21"] = Instance.new("TextLabel", SkinListTab["20"]);
						SkinListTab["21"]["BorderSizePixel"] = 0;
						SkinListTab["21"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						SkinListTab["21"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						SkinListTab["21"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						SkinListTab["21"]["TextSize"] = 14;
						SkinListTab["21"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
						SkinListTab["21"]["Size"] = UDim2.new(1, 0, 1, 0);
						SkinListTab["21"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						SkinListTab["21"]["Text"] = [[Unknown Skin List - Unknown]];
						SkinListTab["21"]["Name"] = [[Title]];
						SkinListTab["21"]["BackgroundTransparency"] = 1;

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.TopBar.Title.UIPadding
						SkinListTab["22"] = Instance.new("UIPadding", SkinListTab["21"]);
						SkinListTab["22"]["PaddingLeft"] = UDim.new(0, 5);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList
						SkinListTab["23"] = Instance.new("Frame", SkinListTab["1f"]);
						SkinListTab["23"]["BorderSizePixel"] = 0;
						SkinListTab["23"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						SkinListTab["23"]["BackgroundTransparency"] = 1;
						SkinListTab["23"]["Size"] = UDim2.new(1, 0, 1, -20);
						SkinListTab["23"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						SkinListTab["23"]["Position"] = UDim2.new(0, 0, 0, 20);
						SkinListTab["23"]["Name"] = [[SkinList]];

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder
						SkinListTab["24"] = Instance.new("Frame", SkinListTab["23"]);
						SkinListTab["24"]["BorderSizePixel"] = 0;
						SkinListTab["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						SkinListTab["24"]["BackgroundTransparency"] = 1;
						SkinListTab["24"]["Size"] = UDim2.new(1, 0, 1, 0);
						SkinListTab["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						SkinListTab["24"]["Name"] = [[Holder]];

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.UIPadding
						SkinListTab["2e"] = Instance.new("UIPadding", SkinListTab["24"]);
						SkinListTab["2e"]["PaddingTop"] = UDim.new(0, 5);
						SkinListTab["2e"]["PaddingLeft"] = UDim.new(0, -7);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.UIGridLayout
						SkinListTab["2f"] = Instance.new("UIGridLayout", SkinListTab["24"]);
						SkinListTab["2f"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
						SkinListTab["2f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
						SkinListTab["2f"]["FillDirectionMaxCells"] = 5;
						SkinListTab["2f"]["CellSize"] = UDim2.new(0, 120, 0, 120);
						SkinListTab["2f"]["CellPadding"] = UDim2.new(0, 10, 0, 10);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.UIStroke
						SkinListTab["30"] = Instance.new("UIStroke", SkinListTab["1f"]);
						SkinListTab["30"]["Color"] = Color3.fromRGB(27, 27, 27);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.ScrollBarBack
						SkinListTab["31"] = Instance.new("Frame", SkinListTab["1f"]);
						SkinListTab["31"]["BorderSizePixel"] = 0;
						SkinListTab["31"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						SkinListTab["31"]["AnchorPoint"] = Vector2.new(1, 0);
						SkinListTab["31"]["BackgroundTransparency"] = 1;
						SkinListTab["31"]["Size"] = UDim2.new(0, 6, 1, -19);
						SkinListTab["31"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						SkinListTab["31"]["Position"] = UDim2.new(1, -1, 0, 19);
						SkinListTab["31"]["Name"] = [[ScrollBarBack]];

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.ScrollBarBack.ScrollBar
						SkinListTab["32"] = Instance.new("Frame", SkinListTab["31"]);
						SkinListTab["32"]["BorderSizePixel"] = 0;
						SkinListTab["32"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
						SkinListTab["32"]["Size"] = UDim2.new(1, 0, 0.5, 0);
						SkinListTab["32"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						SkinListTab["32"]["Name"] = [[ScrollBar]];
					end

					do -- Methods
						function SkinListTab:UpdateFrame()
							
						end

						function SkinListTab:RemoveGun(gun)
							for Index, Value in pairs(SkinListTab["24"]:GetDescendants()) do
								if Value.Name == gun.Name then
									Value:Destroy()
								end
							end
						end

						function SkinListTab:AddSkin(name, icon)
							local Item = {
								Hover = false,
								MouseDown = false,
							}

							SkinListTab.AmountOfSkins += 1

							do -- Render
								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame
								Item["25"] = Instance.new("Frame", SkinListTab["24"]);
								Item["25"]["BorderSizePixel"] = 0;
								Item["25"]["BackgroundColor3"] = Color3.fromRGB(16, 16, 16);
								Item["25"]["Size"] = UDim2.new(0, 100, 0, 100);
								Item["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
								Item["25"]["Name"] = [[SkinFrame]];
								Item["25"]["Visible"] = true;
								Item["25"]["ZIndex"] = 1;

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.SkinName
								Item["26"] = Instance.new("TextLabel", Item["25"]);
								Item["26"]["BorderSizePixel"] = 0;
								Item["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
								Item["26"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
								Item["26"]["TextSize"] = 16;
								Item["26"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
								Item["26"]["AnchorPoint"] = Vector2.new(0, 1);
								Item["26"]["Size"] = UDim2.new(1, 0, 0, 20);
								Item["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
								Item["26"]["Text"] = name ~= nil and name or "N/A";
								Item["26"]["Name"] = [[SkinName]];
								Item["26"]["BackgroundTransparency"] = 1;
								Item["26"]["Position"] = UDim2.new(0, 0, 1, 0);

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.SkinName.UIPadding
								Item["27"] = Instance.new("UIPadding", Item["26"]);
								Item["27"]["PaddingBottom"] = UDim.new(0, 15);

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.UIStroke
								Item["28"] = Instance.new("UIStroke", Item["25"]);
								Item["28"]["Color"] = Color3.fromRGB(31, 31, 31);

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.GunName
								Item["29"] = Instance.new("TextLabel", Item["25"]);
								Item["29"]["BorderSizePixel"] = 0;
								Item["29"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
								Item["29"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
								Item["29"]["TextSize"] = 13;
								Item["29"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
								Item["29"]["TextTransparency"] = 1;
								Item["29"]["AnchorPoint"] = Vector2.new(0, 1);
								Item["29"]["Size"] = UDim2.new(1, 0, 0, 20);
								Item["29"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
								Item["29"]["Text"] = [[N/A]];
								Item["29"]["Name"] = [[GunName]];
								Item["29"]["BackgroundTransparency"] = 1;
								Item["29"]["Position"] = UDim2.new(0, 0, 1, -15);

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.GunName.UIPadding
								Item["2a"] = Instance.new("UIPadding", Item["29"]);
								Item["2a"]["PaddingBottom"] = UDim.new(0, 5);

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.ImageHolder
								Item["2b"] = Instance.new("Frame", Item["25"]);
								Item["2b"]["BorderSizePixel"] = 0;
								Item["2b"]["BackgroundColor3"] = Color3.fromRGB(21, 21, 21);
								Item["2b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
								Item["2b"]["Size"] = UDim2.new(1, -15, 1, -40);
								Item["2b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
								Item["2b"]["Position"] = UDim2.new(0.5, 0, 0.5, -15);
								Item["2b"]["Name"] = [[ImageHolder]];
								
								if icon ~= nil then
									icon.Parent = Item["2b"]
								end

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.ImageHolder.Image
								Item["2c"] = Instance.new("ImageLabel", Item["2b"]);
								Item["2c"]["BorderSizePixel"] = 0;
								Item["2c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
								Item["2c"]["AnchorPoint"] = Vector2.new(0.5, 0);
								Item["2c"]["Size"] = UDim2.new(1, 0, 1, 0);
								Item["2c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
								Item["2c"]["Name"] = [[Image]];
								Item["2c"]["Image"] = "";
								Item["2c"]["BackgroundTransparency"] = 1;
								Item["2c"]["Position"] = UDim2.new(0.5, 0, 0, 0);

								-- StarterGui.MyLibrary.MainBackground.ContentContainer.SkinsTab.SkinListSection.SkinList.Holder.SkinFrame.ImageHolder.UIStroke
								Item["2d"] = Instance.new("UIStroke", Item["2b"]);
								Item["2d"]["Color"] = Color3.fromRGB(27, 27, 27);
							end

							do -- Methods
								function Item:Activate()
									if not Item.Active then

										if SkinListTab.CurrentSkin ~= nil then
											SkinListTab.CurrentSkin:Deactivate()
										end

										Item.Active = true

										SkinListTab.CurrentSkin = Item
									end
								end

								function Item:Deactivate()
									if Item.Active then
										Item.Active = false
										Item.Hover = false
									end
								end
							end

							Item["25"].MouseEnter:Connect(function()
								Item.Hover = true
								if not Item.Active then
									Library:tween(Item["28"], {Color = Color3.fromRGB(55, 55, 55)})
									Library:tween(Item["2d"], {Color = Color3.fromRGB(40, 40, 40)})
								end
							end)

							Item["25"].MouseLeave:Connect(function()
								Item.Hover = false

								if not Item.Active then
									Library:tween(Item["28"], {Color = Color3.fromRGB(30, 30, 30)})
									Library:tween(Item["2d"], {Color = Color3.fromRGB(30, 30, 30)})
								end
							end)

							uis.InputBegan:Connect(function(input, gpe)
								if gpe then return end

								if input.UserInputType == Enum.UserInputType.MouseButton1 and Item.Hover then
									Item:Activate()
								end
							end)

							uis.InputEnded:Connect(function(input, gpe)
								if gpe then return end

								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									Item.MouseDown = false

									if Item.Hover then
										Library:tween(Item["28"], {Color = Color3.fromRGB(55, 55, 55)})
										Library:tween(Item["2d"], {Color = Color3.fromRGB(40, 40, 40)})
									else
										Library:tween(Item["28"], {Color = Color3.fromRGB(30, 30, 30)})
										Library:tween(Item["2d"], {Color = Color3.fromRGB(30, 30, 30)})
									end
								end
							end)

							SkinListTab:UpdateFrame()
						end

						do -- Logic
							SkinListTab["23"].MouseEnter:Connect(function()
								SkinListTab.test = true
								game:GetService("ContextActionService"):BindAction("disable_mouse_input", function()
									return Enum.ContextActionResult.Sink
								end, false, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3, Enum.UserInputType.MouseWheel)
							end)

							SkinListTab["23"].MouseLeave:Connect(function()
								SkinListTab.test = false
								game:GetService("ContextActionService"):UnbindAction("disable_mouse_input")
							end)

							SkinListTab["31"].MouseEnter:Connect(function()
								SkinListTab.test2 = true
							end)

							SkinListTab["31"].MouseLeave:Connect(function()
								SkinListTab.test2 = false
							end)

							do
								local tile_size = 24
								local max_players = 40.6
								local max_bars = math.floor((SkinListTab["23"].AbsoluteSize.Y + 94) / (tile_size + 4))
								max_players = max_players - max_bars

								local function scroll(amount)
									SkinListTab.CurrentScroll = math.clamp(amount, 0, max_players)

									if SkinListTab.CurrentScroll > 0 then
										SkinListTab["24"].Position = UDim2.new(0, 0, 0, SkinListTab.CurrentScroll * -tile_size - ((SkinListTab.CurrentScroll) * 4) + 12)
									else
										SkinListTab["24"].Position = UDim2.new(0, 0, 0, 0)
									end

									SkinListTab["32"].Position = UDim2.new(0, 0, (1 / (max_players + 19)) * SkinListTab.CurrentScroll)
								end

								local function update_scroll(input)
									local sizeY = math.clamp((input.Position.Y - SkinListTab["31"].AbsolutePosition.Y - game:GetService("GuiService"):GetGuiInset().Y) / SkinListTab["31"].AbsoluteSize.Y, 0, 1)
									local value = math.round(math.clamp(max_players * sizeY, 0, max_players))

									scroll(value)
								end

								uis.InputBegan:Connect(function(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 then
										if SkinListTab.test2 then
											SkinListTab.Scrolling = true
											update_scroll{Position = uis:GetMouseLocation() - Vector2.new(0, 36)}
										end
									end
								end)

								uis.InputChanged:Connect(function(input)
									if SkinListTab.Scrolling and input.UserInputType == Enum.UserInputType.MouseMovement then
										update_scroll(input)
									end
								end)

								uis.InputEnded:Connect(function(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 then
										SkinListTab.Scrolling = false
									end
								end)

								SkinListTab["23"].InputChanged:Connect(function(input)
									if input.UserInputType == Enum.UserInputType.MouseWheel then
										if input.Position.Z > 0 then
											scroll(SkinListTab.CurrentScroll - 1)
										else
											scroll(SkinListTab.CurrentScroll + 1)
										end
									end
								end)
							end
						end
					end

					return SkinListTab
				end
			end

			local GunList = SkinList:GunsList()

			local main_gui = players.LocalPlayer.PlayerGui:WaitForChild('MainScreenGui');

			local weapon_skins_gui = main_gui:WaitForChild('WeaponSkinsGUI');
			local gui_body_wrapper = weapon_skins_gui:WaitForChild('Body');
			local body_wrapper = gui_body_wrapper:WaitForChild('Wrapper');
			local skin_view = body_wrapper:WaitForChild('SkinView');
			local skin_view_frame = skin_view:WaitForChild('Frame');
			local guns = skin_view_frame:WaitForChild('Guns').Contents;
			local entries = skin_view_frame:WaitForChild('Skins').Contents.Entries;
			
			repeat task.wait() until players.LocalPlayer.PlayerGui;

			main_gui = wait_for_child(players.LocalPlayer.PlayerGui, 'MainScreenGui');

			weapon_skins_gui = wait_for_child(main_gui, 'WeaponSkinsGUI');

			gui_body_wrapper = wait_for_child(weapon_skins_gui, 'Body');
			body_wrapper = wait_for_child(gui_body_wrapper, 'Wrapper');

			skin_view = wait_for_child(body_wrapper, 'SkinView');
			skin_view_frame = wait_for_child(skin_view, 'Frame');

			guns = wait_for_child(skin_view_frame, 'Guns').Contents;
			entries = wait_for_child(skin_view_frame, 'Skins').Contents.Entries;

			print('Waiting for guns to load...');

			wait_for_child(guns, '[Revolver]');

			print('Guns successfully loaded.');
			
			local regex = '%[(.-)%]';
			
			for i, v in next, guns:GetChildren() do
				if v:IsA('Frame') and v.Name ~= 'GunEntry' and v.Name ~= 'Trading' and v.Name ~= '[Mask]' and v.Name ~= "[Vehicle]"then
					local extracted_name = v.Name:match(regex);
					
					if extracted_name then
						local image = v:FindFirstChild("Container").Preview.Image
						GunList:AddGun(extracted_name, image)
					end;
				end; 
			end
			
			return SkinList
		end
		
		function Tab:Section(options)
			options = Library:Validate({
				Name = "Preview Section",
				Side = "Left"
			}, options or {})
			
			local Section = {}

			do -- Section
				zindexcount -= 1
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.HomeSection.Left.Section
				Section["9"] = Instance.new("Frame", Tab["7"]);
				Section["9"]["BorderSizePixel"] = 0;
				Section["9"]["BackgroundColor3"] = Color3.fromRGB(20, 20, 20);
				Section["9"]["Size"] = UDim2.new(1, 0, 0, 30);
				Section["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Section["9"]["Name"] = [[Section]];
				Section["9"]["AutomaticSize"] = Enum.AutomaticSize.XY;
				Section["9"]["ZIndex"] = zindexcount;
				
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.HomeSection.Left.Section.UIStroke
				Section["a"] = Instance.new("UIStroke", Section["9"]);
				Section["a"]["Color"] = Color3.fromRGB(27, 27, 27);

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.HomeSection.Left.Section.TopBar
				Section["b"] = Instance.new("Frame", Section["9"]);
				Section["b"]["BorderSizePixel"] = 0;
				Section["b"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
				Section["b"]["Size"] = UDim2.new(1, 0, 0, 20);
				Section["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Section["b"]["Name"] = [[TopBar]];

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.HomeSection.Left.Section.TopBar.Title
				Section["c"] = Instance.new("TextLabel", Section["b"]);
				Section["c"]["BorderSizePixel"] = 0;
				Section["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Section["c"]["TextSize"] = 14;
				Section["c"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
				Section["c"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Section["c"]["Text"] = options.Name;
				Section["c"]["Name"] = [[Title]];
				Section["c"]["BackgroundTransparency"] = 1;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.HomeSection.Left.Section.TopBar.Title.UIPadding
				Section["d"] = Instance.new("UIPadding", Section["c"]);
				Section["d"]["PaddingLeft"] = UDim.new(0, 5);

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.HomeSection.Left.Section.ContentContainer
				Section["f"] = Instance.new("Frame", Section["9"]);
				Section["f"]["BorderSizePixel"] = 0;
				Section["f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["f"]["BackgroundTransparency"] = 1;
				Section["f"]["Size"] = UDim2.new(1, 0, 1, -20);
				Section["f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Section["f"]["Position"] = UDim2.new(0, 0, 0, 20);
				Section["f"]["Name"] = [[ContentContainer]];
				
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.UIListLayout
				Section["13"] = Instance.new("UIListLayout", Section["f"]);
				Section["13"]["Padding"] = UDim.new(0, 7);
				Section["13"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.UIPadding
				Section["14"] = Instance.new("UIPadding", Section["f"]);
				Section["14"]["PaddingTop"] = UDim.new(0, 5);
				Section["14"]["PaddingLeft"] = UDim.new(0, 10);
				Section["14"]["PaddingBottom"] = UDim.new(0, 7);
			end
			
			local column = options.Side == "Left" and Tab["8"] or Tab["41"]
			
			Section["9"].Parent = column
			
			function Section:Button(options)
				options = Library:Validate({
					Name = "Preview Button",
					Callback = function() end
				}, options or {})
				

				local Button = {
					Hover = false,
					MouseDown = false,
				}
				
				do -- Render
					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Button
					Button["12"] = Instance.new("Frame", Section["f"]);
					Button["12"]["BorderSizePixel"] = 0;
					Button["12"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14);
					Button["12"]["Size"] = UDim2.new(1, -10, 0, 18);
					Button["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Button["12"]["Position"] = UDim2.new(0, 5, 0, 0);
					Button["12"]["Name"] = [[Button]];

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Button.Text
					Button["13"] = Instance.new("TextLabel", Button["12"]);
					Button["13"]["TextWrapped"] = true;
					Button["13"]["BorderSizePixel"] = 0;
					Button["13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Button["13"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Button["13"]["TextSize"] = 14;
					Button["13"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
					Button["13"]["Size"] = UDim2.new(1, 0, 1, -4);
					Button["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Button["13"]["Text"] = options.Name;
					Button["13"]["Name"] = [[Text]];
					Button["13"]["BackgroundTransparency"] = 1;
					Button["13"]["Position"] = UDim2.new(0, 0, 0, 2);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Button.UIStroke
					Button["14"] = Instance.new("UIStroke", Button["12"]);
					Button["14"]["Color"] = Color3.fromRGB(27, 27, 27);
				end
				
				do -- Methods
					function Button:SetText(text)
						Button["13"].Text = text
						options.Name = text
					end
					
					function Button:SetCallback(fn)
						options.Callback = fn
					end
				end
				
				do -- Logic
					Button["12"].MouseEnter:Connect(function()
						Button.Hover = true
						
						Library:tween(Button["14"], {Color = Color3.fromRGB(50, 50, 50)})
						Library:tween(Button["12"], {BackgroundColor3 = Color3.fromRGB(17, 17, 17)})
					end)
					
					Button["12"].MouseLeave:Connect(function()
						Button.Hover = false

						if not Button.MouseDown then
							Library:tween(Button["14"], {Color = Color3.fromRGB(27, 27, 27)})
							Library:tween(Button["12"], {BackgroundColor3 = Color3.fromRGB(13, 13, 13)})
						end
					end)
					
					
					uis.InputBegan:Connect(function(input, gpe)
						if gpe then return end

						if input.UserInputType == Enum.UserInputType.MouseButton1 and Button.Hover then
							Button.MouseDown = true
							Library:tween(Button["14"], {Color = Color3.fromRGB(80, 80, 80)})
							Library:tween(Button["12"], {BackgroundColor3 = Color3.fromRGB(50, 50, 50)})
							
							options.Callback()
						end
					end)

					uis.InputEnded:Connect(function(input, gpe)
						if gpe then return end
						
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							Button.MouseDown = false
							
							if Button.Hover then
								Library:tween(Button["14"], {Color = Color3.fromRGB(50, 50, 50)})
								Library:tween(Button["12"], {BackgroundColor3 = Color3.fromRGB(17, 17, 17)})
							else
								Library:tween(Button["14"], {Color = Color3.fromRGB(27, 27, 27)})
								Library:tween(Button["12"], {BackgroundColor3 = Color3.fromRGB(13, 13, 13)})
							end
						end
					end)
				end
				
				return Button
				
			end
			
			function Section:Label(options)
				options = Library:Validate({
					Message = "Preview Label"
				}, options or {})
				
				local Label = {}
				
				do -- Render
					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Label
					Label["41"] = Instance.new("Frame", Section["f"]);
					Label["41"]["BorderSizePixel"] = 0;
					Label["41"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14);
					Label["41"]["BackgroundTransparency"] = 1;
					Label["41"]["Size"] = UDim2.new(1, -10, 0, 12);
					Label["41"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Label["41"]["Position"] = UDim2.new(0, 0, 0, 119);
					Label["41"]["Name"] = [[Label]];

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Label.Text
					Label["42"] = Instance.new("TextLabel", Label["41"]);
					Label["42"]["TextWrapped"] = true;
					Label["42"]["BorderSizePixel"] = 0;
					Label["42"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Label["42"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Label["42"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Label["42"]["TextSize"] = 14;
					Label["42"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
					Label["42"]["Size"] = UDim2.new(1, 0, 1, 0);
					Label["42"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Label["42"]["Name"] = [[Text]];
					Label["42"]["Text"] = options.Message;
					Label["42"]["BackgroundTransparency"] = 1;
				end
				
				do -- Methods
					function Label:ColorPicker(options)

					end
				end
				
				do -- Methods
					function Label:SetText(text)
						options.Message = text
						Label:_Update()
					end
					
					function Label:_Update()
						Label["42"].Text = options.Message
						
						Label["42"].Size = UDim2.new(Label["42"].Size.X.Scale, Label["42"].Size.X.Offset, 0, math.huge)
						Label["42"].Size = UDim2.new(Label["42"].Size.X.Scale, Label["42"].Size.X.Offset, 0, Label["42"].TextBounds.Y)
						Label["41"].Size = UDim2.new(Label["41"].Size.X.Scale, Label["41"].Size.X.Offset, 0, Label["42"].TextBounds.Y + 4)
					end
				end
				
				Label:_Update()
				return Label
			end
			
			function Section:Toggle(options)
				options = Library:Validate({
					Default = false,
					Name = "Preview Toggle",
					Flag = Library.NewFlag(),
					Callback = function() end
				}, options or {})
				
				if not options.Default then
					Library.Flags[options.Default] = options.Default
					options.Callback(options.Default)
				end
				
				local Toggle = {
					Hover = false,
					MouseDown = false,
					State = false,
				}
				
				function Toggle:GetName()
					return options.Name
				end
				
				do -- Render
					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Toggle
					Toggle["35"] = Instance.new("Frame", Section["f"]);
					Toggle["35"]["BorderSizePixel"] = 0;
					Toggle["35"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14);
					Toggle["35"]["BackgroundTransparency"] = 1;
					Toggle["35"]["Size"] = UDim2.new(1, -10, 0, 12);
					Toggle["35"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Toggle["35"]["Position"] = UDim2.new(0, 0, 0, 94);
					Toggle["35"]["Name"] = [[Toggle]];

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Toggle.Text
					Toggle["36"] = Instance.new("TextLabel", Toggle["35"]);
					Toggle["36"]["TextWrapped"] = true;
					Toggle["36"]["BorderSizePixel"] = 0;
					Toggle["36"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Toggle["36"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Toggle["36"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Toggle["36"]["TextSize"] = 14;
					Toggle["36"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
					Toggle["36"]["Size"] = UDim2.new(1, 0, 1, -4);
					Toggle["36"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Toggle["36"]["Text"] = options.Name;
					Toggle["36"]["Name"] = [[Text]];
					Toggle["36"]["BackgroundTransparency"] = 1;
					Toggle["36"]["Position"] = UDim2.new(0, 0, 0, 2);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Toggle.Text.UIPadding
					Toggle["37"] = Instance.new("UIPadding", Toggle["36"]);
					Toggle["37"]["PaddingLeft"] = UDim.new(0, 17);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Toggle.checkmarkHolder
					Toggle["38"] = Instance.new("Frame", Toggle["35"]);
					Toggle["38"]["BorderSizePixel"] = 0;
					Toggle["38"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14);
					Toggle["38"]["Size"] = UDim2.new(0, 9, 0, 9);
					Toggle["38"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Toggle["38"]["Position"] = UDim2.new(0, 0, 0, 2);
					Toggle["38"]["Name"] = [[checkmarkHolder]];

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Toggle.checkmarkHolder.UIStroke
					Toggle["39"] = Instance.new("UIStroke", Toggle["38"]);
					Toggle["39"]["Color"] = Color3.fromRGB(27, 27, 27);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Toggle
					Toggle["3a"] = Instance.new("Frame", Toggle["f"]);
					Toggle["3a"]["BorderSizePixel"] = 0;
					Toggle["3a"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14);
					Toggle["3a"]["BackgroundTransparency"] = 1;
					Toggle["3a"]["Size"] = UDim2.new(1, -10, 0, 12);
					Toggle["3a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Toggle["3a"]["Position"] = UDim2.new(0, 0, 0, 119);
					Toggle["3a"]["Name"] = [[Toggle]];

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Toggle.Text
					Toggle["3b"] = Instance.new("TextLabel", Toggle["3a"]);
					Toggle["3b"]["TextWrapped"] = true;
					Toggle["3b"]["BorderSizePixel"] = 0;
					Toggle["3b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Toggle["3b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Toggle["3b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Toggle["3b"]["TextSize"] = 14;
					Toggle["3b"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
					Toggle["3b"]["Size"] = UDim2.new(1, 0, 1, -4);
					Toggle["3b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Toggle["3b"]["Text"] = [[Toggle]];
					Toggle["3b"]["Name"] = [[Text]];
					Toggle["3b"]["BackgroundTransparency"] = 1;
					Toggle["3b"]["Position"] = UDim2.new(0, 0, 0, 2);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Toggle.Text.UIPadding
					Toggle["3c"] = Instance.new("UIPadding", Toggle["3b"]);
					Toggle["3c"]["PaddingLeft"] = UDim.new(0, 17);
				end
				
				function Toggle:GetFlag()
					return options.Flag
				end
				
				function Toggle:GetState()
					return Toggle.State
				end
				
				function Toggle:GetCallback(b)
					options.Callback(b)
				end
				
				do -- Methods
					function Toggle:Keybind(options)
						options = Library:Validate({
							Default = Enum.KeyCode.W,
							Mode = "Toggle",
						}, options or {})
						
						Toggle.Keybind = true
						
						local Keybind = {
							Hover = false,
							MouseDown = false,
							Keybind = options.Default ~= nil and options.Default or "None",
							State = false,
						}
						
						do -- Render
							-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Toggle.Keybind
							Keybind["36"] = Instance.new("Frame", Toggle["35"]);
							Keybind["36"]["BorderSizePixel"] = 0;
							Keybind["36"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14);
							Keybind["36"]["Size"] = UDim2.new(0, 30, 0, 13);
							Keybind["36"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Keybind["36"]["Position"] = UDim2.new(1, -30, 0, 0);
							Keybind["36"]["Name"] = [[Keybind]];
							Keybind["36"]["ZIndex"] = 2;

							-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Toggle.Keybind.UIPadding
							Keybind["37"] = Instance.new("UIPadding", Keybind["36"]);


							-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Toggle.Keybind.TextLabel
							Keybind["38"] = Instance.new("TextLabel", Keybind["36"]);
							Keybind["38"]["BorderSizePixel"] = 0;
							Keybind["38"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
							Keybind["38"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
							Keybind["38"]["TextSize"] = 14;
							Keybind["38"]["TextColor3"] = Color3.fromRGB(215, 215, 215);
							Keybind["38"]["Size"] = UDim2.new(1, 0, 1, 0);
							Keybind["38"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Keybind["38"]["Text"] = "None";
							Keybind["38"]["BackgroundTransparency"] = 1;

							-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Toggle.Keybind.UIStroke
							Keybind["39"] = Instance.new("UIStroke", Keybind["36"]);
							Keybind["39"]["Color"] = Color3.fromRGB(27, 27, 27);
						end
						
						function Toggle:GetKeybind()
							return Keybind.Keybind
						end
						
						local function set(key)
							if typeof(key) == "string" then
								if key:find("KEY") then
									key = Enum.KeyCode[key:gsub("KEY_", "")]
								elseif key:find("INPUT") then
									key = Enum.UserInputType[key:gsub("INPUT_", "")]
								end
							end
							
							if blacklisted_keys[key] then
								key = nil
							end

							if key and (keys[key] or uis:GetStringForKeyCode(key) ~= "") then
								local key_str = keys[key] or uis:GetStringForKeyCode(key)
								Keybind.Keybind = key_str
								Toggle["36"].Size = UDim2.new(1, -Keybind["36"].AbsoluteSize.X + 20, 1, -4)
								Keybind["38"].Text = key_str
								Keybind["36"].Size = UDim2.new(0, Keybind["38"].TextBounds.X + 25, 0, 13)
								Keybind["36"].Position = UDim2.new(1, -(Keybind["38"].TextBounds.X + 25), 0, 0)
							else
								Keybind.Keybind = "None"
								
								Toggle["36"].Size = UDim2.new(1, -Keybind["36"].AbsoluteSize.X - 30, 1, -4)
								Keybind["38"].Text = Keybind.Keybind
								Keybind["36"].Size = UDim2.new(0, Keybind["38"].TextBounds.X + 25, 0, 13)
								Keybind["36"].Position = UDim2.new(1, -(Keybind["38"].TextBounds.X + 25), 0, 0)
							end
						end
						
						set(options.Default)
						
						Keybind["36"].MouseEnter:Connect(function()
							Keybind.Hover = true
						end)
						
						Keybind["36"].MouseLeave:Connect(function()
							Keybind.Hover = false
						end)
						
						local binding

						uis.InputBegan:Connect(function(input, gpe)
							if gpe then return end
							
							if Keybind.Hover and input.UserInputType == Enum.UserInputType.MouseButton1 then
								
								if binding then
									binding:Disconnect()
								end
								
								Keybind["38"].Text = "..."
								
								binding = uis.InputBegan:Connect(function(input)
									set(input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType)
									binding:Disconnect()
									task.wait()
									binding = nil
								end)
							end
						end)
						
						uis.InputBegan:Connect(function(input, gpe)
							if gpe then return end
							
							if input.UserInputType == Enum.UserInputType.Keyboard and Keybind.Keybind ~= "None" and input.KeyCode == Enum.KeyCode[Keybind.Keybind] then
								Keybind:Toggle()
							end
						end)
						
						uis.InputEnded:Connect(function(input, gpe)
							if gpe then return end
							
							if options.Mode == "Hold" or options.Mode == "Off Hold" then
								if input.UserInputType == Enum.UserInputType.Keyboard and Keybind.Keybind ~= "None" and input.KeyCode == Enum.KeyCode[Keybind.Keybind] then
									Keybind:Toggle()
								end
							end
						end)
						
						function Keybind:Toggle(b)
							if Toggle:GetState() then
								if b == nil then
									Keybind.State = not Keybind.State
								else
									Keybind.State = b
								end
								
								if options.Mode ~= "Off Hold" then
									if Keybind.State then
										GUI:AddKeybind(Toggle:GetName(), Toggle:GetKeybind())
									else
										GUI:RemoveKeybind(Toggle:GetName())
									end
									
									Library.Flags[Toggle:GetFlag()] = Keybind.State
									Toggle:GetCallback(Keybind.State)
								else
									if not Keybind.State then
										GUI:AddKeybind(Toggle:GetName(), Toggle:GetKeybind())
									else
										GUI:RemoveKeybind(Toggle:GetName())
									end
									
									Library.Flags[Toggle:GetFlag()] = not Keybind.State
									Toggle:GetCallback(not Keybind.State)
								end
							end
						end
						
						return Keybind
					end

					function Toggle:ColorPicker(options)
						
					end
					
					function Toggle:Toggle(b)
						if b == nil then
							Toggle.State = not Toggle.State
						else
							Toggle.State = b
						end

						if Toggle.State then
							Library:tween(Toggle["38"], {BackgroundColor3 = Color3.fromRGB(0, 255, 0)})
						else
							Library:tween(Toggle["38"], {BackgroundColor3 = Color3.fromRGB(13, 13, 13)})
							GUI:RemoveKeybind(options.Name)
						end

						Library.Flags[options.Flag] = Toggle.State
						options.Callback(Toggle.State)
					end
				end

				if options.Default == true then
					Toggle:Toggle(true)
				end
				
				do -- Logic
					Toggle["36"].MouseEnter:Connect(function()
						Toggle.Hover = true

						Library:tween(Toggle["39"], {Color = Color3.fromRGB(55, 55, 55)})
					end)

					Toggle["36"].MouseLeave:Connect(function()
						Toggle.Hover = false

						if not Toggle.MouseDown then
							Library:tween(Toggle["39"], {Color = Color3.fromRGB(27, 27, 27)})
						end
					end)


					uis.InputBegan:Connect(function(input, gpe)
						if gpe then return end

						if input.UserInputType == Enum.UserInputType.MouseButton1 and Toggle.Hover then
							Toggle.MouseDown = true
							Library:tween(Toggle["39"], {Color = Color3.fromRGB(80, 80, 80)})
							Toggle:Toggle()
						end
					end)

					uis.InputEnded:Connect(function(input, gpe)
						if gpe then return end

						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							Toggle.MouseDown = false

							if Toggle.Hover then
								Library:tween(Toggle["39"], {Color = Color3.fromRGB(55, 55, 55)})
							else
								Library:tween(Toggle["39"], {Color = Color3.fromRGB(27, 27, 27)})
							end
						end
					end)
				end
				
				return Toggle
			end
			
			function Section:Slider(options)
				options = Library:Validate({
					Name = "Preview Slider",
					Min = 0,
					Max = 100,
					Default = 1,
					Decimal = 1,
					Flag = Library.NewFlag(),
					Callback = function() end
				}, options or {})
				

				local Slider = {
					Hover = false,
					MouseDown = false,
					Connection = nil,
					CurrentValue = -9999,
				}
				
				do -- Render
					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Slider
					Slider["17"] = Instance.new("Frame", Section["f"]);
					Slider["17"]["BorderSizePixel"] = 0;
					Slider["17"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14);
					Slider["17"]["BackgroundTransparency"] = 1;
					Slider["17"]["Size"] = UDim2.new(1, -10, 0, 25);
					Slider["17"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Slider["17"]["Position"] = UDim2.new(0, 0, 0, 25);
					Slider["17"]["Name"] = [[Slider]];

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Slider.Text
					Slider["18"] = Instance.new("TextLabel", Slider["17"]);
					Slider["18"]["TextWrapped"] = true;
					Slider["18"]["BorderSizePixel"] = 0;
					Slider["18"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Slider["18"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Slider["18"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Slider["18"]["TextSize"] = 14;
					Slider["18"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
					Slider["18"]["Size"] = UDim2.new(0.5, 0, 1, -10);
					Slider["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Slider["18"]["Text"] = options.Name;
					Slider["18"]["Name"] = [[Text]];
					Slider["18"]["BackgroundTransparency"] = 1;
					Slider["18"]["Position"] = UDim2.new(0, 0, 0, -1);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Slider.Value
					Slider["19"] = Instance.new("TextLabel", Slider["17"]);
					Slider["19"]["TextWrapped"] = true;
					Slider["19"]["BorderSizePixel"] = 0;
					Slider["19"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Slider["19"]["TextXAlignment"] = Enum.TextXAlignment.Right;
					Slider["19"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Slider["19"]["TextSize"] = 14;
					Slider["19"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
					Slider["19"]["Size"] = UDim2.new(0.5, 0, 1, -5);
					Slider["19"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Slider["19"]["Text"] = [[100]];
					Slider["19"]["Name"] = [[Value]];
					Slider["19"]["BackgroundTransparency"] = 1;
					Slider["19"]["Position"] = UDim2.new(0.5, 0, 0, -6);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Slider.Value.UIPadding
					Slider["1a"] = Instance.new("UIPadding", Slider["19"]);
					Slider["1a"]["PaddingTop"] = UDim.new(0, 8);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Slider.SliderBack
					Slider["1b"] = Instance.new("Frame", Slider["17"]);
					Slider["1b"]["BorderSizePixel"] = 0;
					Slider["1b"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14);
					Slider["1b"]["AnchorPoint"] = Vector2.new(0, 1);
					Slider["1b"]["Size"] = UDim2.new(1, 0, 0, 8);
					Slider["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Slider["1b"]["Position"] = UDim2.new(0, 0, 1, 0);
					Slider["1b"]["Name"] = [[SliderBack]];

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Slider.SliderBack.UIStroke
					Slider["1c"] = Instance.new("UIStroke", Slider["1b"]);
					Slider["1c"]["Color"] = Color3.fromRGB(27, 27, 27);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Left.Section.ContentContainer.Slider.SliderBack.Draggable
					Slider["1d"] = Instance.new("Frame", Slider["1b"]);
					Slider["1d"]["BorderSizePixel"] = 0;
					Slider["1d"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
					Slider["1d"]["Size"] = UDim2.new(0.5, 0, 1, 0);
					Slider["1d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Slider["1d"]["Name"] = [[Draggable]];
				end
				
				local function get(value)
					return ("%.14g"):format(value)
				end
				
				local function set(value)
					value = math.clamp(options.Decimal * math.round(tonumber(value) / options.Decimal), options.Min, options.Max)
					Slider["19"].Text = tostring(get(value))

					if value ~= Slider.CurrentValue then
						Slider.CurrentValue = value
						Slider["1d"].Size = UDim2.new((value - options.Min) / (options.Max - options.Min), 0, 1, 0)
					end

					Library.Flags[options.Flag] = get(value)
					options.Callback(get(value))
				end

				set(options.Default)

				local function slide(input)
					local sizeX = (input.Position.X - Slider["1b"].AbsolutePosition.X) / Slider["1b"].AbsoluteSize.X
					local value = math.clamp((options.Max - options.Min) * sizeX + options.Min, options.Min, options.Max)

					set(value)
				end
				
				do -- Logic
					Slider["1b"].MouseEnter:Connect(function()
						Slider.Hover = true
					end)

					Slider["1b"].MouseLeave:Connect(function()
						Slider.Hover = false
					end)

					uis.InputBegan:Connect(function(input, gpe)
						if gpe then return end

						if input.UserInputType == Enum.UserInputType.MouseButton1 and Slider.Hover then
							Slider.MouseDown = true
							slide{Position = uis:GetMouseLocation()}
						end
					end)
					
					uis.InputChanged:Connect(function(input)
						if Slider.MouseDown and input.UserInputType == Enum.UserInputType.MouseMovement then
							slide(input)
						end
					end)

					uis.InputEnded:Connect(function(input, gpe)
						if gpe then return end

						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							Slider.MouseDown = false
						end
					end)
				end
				
				return Slider
			end
			
			function Section:Dropdown(options)
				options = Library:Validate({
					Default = "None",
					Name = "Preview Dropdown",
					Content = {},
					Flag = Library.NewFlag(),
					Callback = function() end
				}, options or {})
				
				local Dropdown = {
					Items = {
						["id"] = {}
					},
					Open = false,
					MouseDown = false,
					Hover = false,
				}
				
				if not options.Default then
					Library.Flags[options.Default] = options.Default
					options.Callback(options.Default)
				end

				if options.Default ~= "None" then
					options.Callback(options.Default)
				end
				
				do -- Render
					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen
					Dropdown["be"] = Instance.new("Frame", Section["f"]);
					Dropdown["be"]["BorderSizePixel"] = 0;
					Dropdown["be"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14);
					Dropdown["be"]["BackgroundTransparency"] = 1;
					Dropdown["be"]["Size"] = UDim2.new(1, -10, 0, 35);
					Dropdown["be"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["be"]["Position"] = UDim2.new(0, 0, 0, 57);
					Dropdown["be"]["Name"] = [[DropdownOpen]];
					Dropdown["be"]["ZIndex"] = 10;

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Text
					Dropdown["bf"] = Instance.new("TextLabel", Dropdown["be"]);
					Dropdown["bf"]["TextWrapped"] = true;
					Dropdown["bf"]["BorderSizePixel"] = 0;
					Dropdown["bf"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["bf"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Dropdown["bf"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Dropdown["bf"]["TextSize"] = 14;
					Dropdown["bf"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
					Dropdown["bf"]["Size"] = UDim2.new(1, 0, 1, -20);
					Dropdown["bf"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["bf"]["Text"] = options.Name;
					Dropdown["bf"]["Name"] = [[Text]];
					Dropdown["bf"]["BackgroundTransparency"] = 1;
					Dropdown["bf"]["Position"] = UDim2.new(0, 0, 0, 2);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options
					Dropdown["c0"] = Instance.new("Frame", Dropdown["be"]);
					Dropdown["c0"]["BorderSizePixel"] = 0;
					Dropdown["c0"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14);
					Dropdown["c0"]["Size"] = UDim2.new(1, 0, 1, -20);
					Dropdown["c0"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["c0"]["Position"] = UDim2.new(0, 0, 0, 22);
					Dropdown["c0"]["Name"] = [[Options]];

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.UIStroke
					Dropdown["c1"] = Instance.new("UIStroke", Dropdown["c0"]);
					Dropdown["c1"]["Color"] = Color3.fromRGB(27, 27, 27);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Option
					Dropdown["c2"] = Instance.new("TextLabel", Dropdown["c0"]);
					Dropdown["c2"]["BorderSizePixel"] = 0;
					Dropdown["c2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["c2"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Dropdown["c2"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Dropdown["c2"]["TextSize"] = 13;
					Dropdown["c2"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
					Dropdown["c2"]["Size"] = UDim2.new(1, 0, 1, 0);
					Dropdown["c2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["c2"]["Text"] = options.Default ~= nil and options.Default or "None";
					Dropdown["c2"]["Name"] = [[Option]];
					Dropdown["c2"]["BackgroundTransparency"] = 1;
					Dropdown["c2"]["ZIndex"] = 7;

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Option.UIPadding
					Dropdown["c3"] = Instance.new("UIPadding", Dropdown["c2"]);
					Dropdown["c3"]["PaddingLeft"] = UDim.new(0, 5);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Image
					Dropdown["c4"] = Instance.new("ImageLabel", Dropdown["c0"]);
					Dropdown["c4"]["BorderSizePixel"] = 0;
					Dropdown["c4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["c4"]["ImageColor3"] = Color3.fromRGB(0, 255, 0);
					Dropdown["c4"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
					Dropdown["c4"]["Image"] = [[rbxassetid://16863837958]];
					Dropdown["c4"]["Size"] = UDim2.new(0, 8, 0, 8);
					Dropdown["c4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["c4"]["Name"] = [[Image]];
					Dropdown["c4"]["BackgroundTransparency"] = 1;
					Dropdown["c4"]["Position"] = UDim2.new(1, -8, 0.5, 0);

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Background
					Dropdown["c5"] = Instance.new("Frame", Dropdown["c0"]);
					Dropdown["c5"]["BorderSizePixel"] = 0;
					Dropdown["c5"]["BackgroundTransparency"] = 1;
					Dropdown["c5"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25);
					Dropdown["c5"]["Visible"] = false;
					Dropdown["c5"]["Size"] = UDim2.new(1, 0, 0, 22);
					Dropdown["c5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["c5"]["Position"] = UDim2.new(0, 0, 1, 0);
					Dropdown["c5"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					Dropdown["c5"]["Name"] = [[Background]];
					Dropdown["c5"]["ZIndex"] = 5;

					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Background.UIListLayout
					Dropdown["c6"] = Instance.new("UIListLayout", Dropdown["c5"]);
					Dropdown["c6"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
					
					-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Background.UIPadding
					Dropdown["cc"] = Instance.new("UIPadding", Dropdown["c5"]);
					Dropdown["cc"]["PaddingTop"] = UDim.new(0, 1);
					Dropdown["cc"]["PaddingBottom"] = UDim.new(0, 2);
				end
				
				do -- Methods
					function Dropdown:Add(id, value)
						do -- Render
							local Item = {
								Hover = false,
								MouseDown = false,
							}
							
							if Item[id] ~= nil then
								return
							end
							
							Item[id] = {
								instance = {},
								value = value
							}
							
							-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Background.Inactive
							Item["c7"] = Instance.new("Frame", Dropdown["c5"]);
							Item["c7"]["BorderSizePixel"] = 0;
							Item["c7"]["BackgroundColor3"] = Color3.fromRGB(13, 13, 13);
							Item["c7"]["BackgroundTransparency"] = 0;
							Item["c7"]["Size"] = UDim2.new(1, 0, 0, 18);
							Item["c7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Item["c7"]["Name"] = [[Option]];
							Item["c7"]["ZIndex"] = 8;
							
							-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Background.Inactive.Text.UIPadding
							Item["f3"] = Instance.new("UIPadding", Item["c7"]);
							Item["f3"]["PaddingTop"] = UDim.new(0, -1);
							
							-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.UIStroke
							Item["f5"] = Instance.new("UIStroke", Item["c7"]);
							Item["f5"]["Color"] = Color3.fromRGB(20, 20, 20);

							-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Background.Inactive.Text
							Item["c8"] = Instance.new("TextLabel", Item["c7"]);
							Item["c8"]["BorderSizePixel"] = 0;
							Item["c8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
							Item["c8"]["TextXAlignment"] = Enum.TextXAlignment.Left;
							Item["c8"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
							Item["c8"]["TextSize"] = 14;
							Item["c8"]["TextColor3"] = Color3.fromRGB(150, 150, 150);
							Item["c8"]["Size"] = UDim2.new(1, 0, 0, 18);
							Item["c8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Item["c8"]["Text"] = value;
							Item["c8"]["Name"] = [[Text]];
							Item["c8"]["BackgroundTransparency"] = 1;

							-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Background.Inactive.Text.UIPadding
							Item["c9"] = Instance.new("UIPadding", Item["c8"]);
							Item["c9"]["PaddingLeft"] = UDim.new(0, 3);

							-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Background.Inactive.Frame
							Item["ca"] = Instance.new("Frame", Item["c7"]);
							Item["ca"]["BorderSizePixel"] = 0;
							Item["ca"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
							Item["ca"]["BackgroundTransparency"] = 1;
							Item["ca"]["Size"] = UDim2.new(0, 1, 1, -6);
							Item["ca"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Item["ca"]["Position"] = UDim2.new(0, 0, 0, 3);

							-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Background.Inactive.UIPadding
							Item["cb"] = Instance.new("UIPadding", Item["c7"]);
							
							Item["c7"].MouseEnter:Connect(function()
								Item.Hover = true
								Library:tween(Item["c8"], {TextColor3 = Color3.fromRGB(214, 214, 214)})
							end)

							Item["c7"].MouseLeave:Connect(function()
								Item.Hover = false

								if not Item.MouseDown then
									Library:tween(Item["c8"], {TextColor3 = Color3.fromRGB(150, 150, 150)})
								end
							end)


							uis.InputBegan:Connect(function(input, gpe)
								if gpe then return end

								if input.UserInputType == Enum.UserInputType.MouseButton1 and Item.Hover then
									Item.MouseDown = true
									Library:tween(Item["c8"], {TextColor3 = Color3.fromRGB(255, 255, 255)})

									Library.Flags[options.Flag] = value
									options.Callback(value)
									Dropdown:Toggle()
									Dropdown["c2"].Text = value
								end
							end)

							uis.InputEnded:Connect(function(input, gpe)
								if gpe then return end

								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									Item.MouseDown = false

									if Item.Hover then
										Library:tween(Item["c8"], {TextColor3 = Color3.fromRGB(214, 214, 214)})
									else
										Library:tween(Item["c8"], {TextColor3 = Color3.fromRGB(150, 150, 150)})
									end
								end
							end)
						end
					end
					
					function Dropdown:Toggle()
						if Dropdown.Open then
							Dropdown["c5"].Visible = false
							Library:tween(Dropdown["c4"], {Size = UDim2.new(0, 8, 0, 8)})
						else
							Dropdown["c5"].Visible = true
							Library:tween(Dropdown["c4"], {Size = UDim2.new(0, 10, 0, 10)})
						end
						
						Dropdown.Open = not Dropdown.Open
					end
				end
				
				do -- Logic
					for i, v in pairs(options.Content) do
						Dropdown:Add(i, v)
					end
					
					Dropdown["c0"].MouseEnter:Connect(function()
						Dropdown.Hover = true
						Library:tween(Dropdown["c1"], {Color = Color3.fromRGB(55, 55, 55)})
					end)

					Dropdown["c0"].MouseLeave:Connect(function()
						Dropdown.Hover = false

						if not Dropdown.MouseDown then
							Library:tween(Dropdown["c1"], {Color = Color3.fromRGB(27, 27, 27)})
						end
					end)


					uis.InputBegan:Connect(function(input, gpe)
						if gpe then return end

						if input.UserInputType == Enum.UserInputType.MouseButton1 and Dropdown.Hover then
							Dropdown.MouseDown = true
							Library:tween(Dropdown["c1"], {Color = Color3.fromRGB(80, 80, 80)})
							Dropdown:Toggle()
						end
					end)

					uis.InputEnded:Connect(function(input, gpe)
						if gpe then return end

						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							Dropdown.MouseDown = false

							if Dropdown.Hover then
								Library:tween(Dropdown["c1"], {Color = Color3.fromRGB(55, 55, 55)})
							else
								Library:tween(Dropdown["c1"], {Color = Color3.fromRGB(27, 27, 27)})
							end
						end
					end)
				end
				
				return Dropdown
			end
			
			return Section
		end
		
		return Tab
	end
	
	function Library:Unload()
		if GUI["1"] then GUI["1"]:Destroy() end
	end
	
	function Library:Init()
		
		local gui = GUI["2"]

		local dragging
		local dragInput
		local dragStart
		local startPos

		local function update(input)
			local delta = input.Position - dragStart
			gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end

		GUI["57"].InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = gui.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		GUI["57"].InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		uis.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)
	end
	
	return GUI
end

function Library:Notify(Content: string, Delay: number)
	assert(typeof(Content) == "string", "missing argument #1, (string expected got " .. typeof(Content) .. ")")
	local Delay = typeof(Delay) == "number" and Delay or 3
	
	local Notification = {}
	
	do -- Render
		Notification["1"] = Instance.new("ScreenGui", runService:IsStudio() and players.LocalPlayer:WaitForChild("PlayerGui") or coreGui);
		Notification["1"]["Name"] = [[Notification]];
		Notification["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
		Notification["1"]["ResetOnSpawn"] = false;
		Notification["1"]["IgnoreGuiInset"] = true;
		
		-- StarterGui.Notification.MainFrame
		Notification["2"] = Instance.new("Frame", Notification["1"]);
		Notification["2"]["BorderSizePixel"] = 0;
		Notification["2"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31);
		Notification["2"]["Size"] = UDim2.new(0, 100, 0, 26);
		Notification["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Notification["2"]["Position"] = UDim2.new(0, -50, 0, 80);
		Notification["2"]["Name"] = [[MainFrame]];
		
		-- StarterGui.MyLibrary.MainBackground.UIStroke
		Notification["3"] = Instance.new("UIStroke", Notification["2"]);
		Notification["3"]["Color"] = Color3.fromRGB(20, 20, 20);
		Notification["3"]["LineJoinMode"] = Enum.LineJoinMode.Miter;

		-- StarterGui.Notification.MainFrame.DropShadowHolder
		Notification["3"] = Instance.new("Frame", Notification["2"]);
		Notification["3"]["ZIndex"] = 0;
		Notification["3"]["BorderSizePixel"] = 0;
		Notification["3"]["BackgroundTransparency"] = 1;
		Notification["3"]["Size"] = UDim2.new(1, 0, 1, 0);
		Notification["3"]["Name"] = [[DropShadowHolder]];

		-- StarterGui.Notification.MainFrame.DropShadowHolder.DropShadow
		Notification["4"] = Instance.new("ImageLabel", Notification["3"]);
		Notification["4"]["ZIndex"] = 0;
		Notification["4"]["BorderSizePixel"] = 0;
		Notification["4"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
		Notification["4"]["ScaleType"] = Enum.ScaleType.Slice;
		Notification["4"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
		Notification["4"]["ImageTransparency"] = 0.5;
		Notification["4"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		Notification["4"]["Image"] = [[rbxassetid://6014261993]];
		Notification["4"]["Size"] = UDim2.new(1, 30, 1, 30);
		Notification["4"]["Name"] = [[DropShadow]];
		Notification["4"]["BackgroundTransparency"] = 1;
		Notification["4"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

		-- StarterGui.Notification.MainFrame.LeftBar
		Notification["5"] = Instance.new("Frame", Notification["2"]);
		Notification["5"]["BorderSizePixel"] = 0;
		Notification["5"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
		Notification["5"]["Size"] = UDim2.new(0, 1, 1, -6);
		Notification["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Notification["5"]["Position"] = UDim2.new(0, 2, 0, 3);
		Notification["5"]["Name"] = [[LeftBar]];

		-- StarterGui.Notification.MainFrame.TimerBar
		Notification["6"] = Instance.new("Frame", Notification["2"]);
		Notification["6"]["BorderSizePixel"] = 0;
		Notification["6"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
		Notification["6"]["AnchorPoint"] = Vector2.new(0, 1);
		Notification["6"]["Size"] = UDim2.new(1, -4, 0, 1);
		Notification["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Notification["6"]["Position"] = UDim2.new(0, 2, 1, -3);
		Notification["6"]["Name"] = [[TimerBar]];

		-- StarterGui.Notification.MainFrame.Text
		Notification["7"] = Instance.new("TextLabel", Notification["2"]);
		Notification["7"]["BorderSizePixel"] = 0;
		Notification["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		Notification["7"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		Notification["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Notification["7"]["TextSize"] = 14;
		Notification["7"]["TextColor3"] = Color3.fromRGB(215, 215, 215);
		Notification["7"]["Size"] = UDim2.new(1, 0, 1, 0);
		Notification["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Notification["7"]["Text"] = Content;
		Notification["7"]["Name"] = [[Text]];
		Notification["7"]["BackgroundTransparency"] = 1;

		-- StarterGui.Notification.MainFrame.Text.UIPadding
		Notification["8"] = Instance.new("UIPadding", Notification["7"]);
		Notification["8"]["PaddingBottom"] = UDim.new(0, 3);
		Notification["8"]["PaddingLeft"] = UDim.new(0, 7);
		
		local NotificationFrame = {
			self = Notification["2"],
			Class = "Notification",
		}
		
		function Notification:Destroy()
			Notifications[NotificationFrame] = nil
			for i, v in pairs(Notification["2"]:GetDescendants()) do
				if v:IsA("Frame") then
					tweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				elseif v:IsA("TextLabel") then
					tweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
				elseif v:IsA("ImageLabel") then
					tweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
				elseif v:IsA("UIStroke") then
					tweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Transparency = 1}):Play()
				end
			end
			
			local MainUITween = tweenService:Create(Notification["2"], TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
			MainUITween:Play()
			
			MainUITween.Completed:Connect(function()
				Notification["1"]:Destroy()
			end)

			local Index = 1
			for _, v in pairs(Notifications) do
				local self = v.self
				tweenService:Create(self, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(self.Position.X.Scale, self.Position.X.Offset, self.Position.Y.Scale, self.Position.Y.Offset - 30)}):Play()
				Index += 1
			end
		end
		
		function Notification:Update()
			Notification["2"].Size = UDim2.new(0, Notification["7"].TextBounds.X + 10, 0, 26)
			
			local TweenPositionIn = tweenService:Create(Notification["2"], TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0, 10, 0, 80 + GetDictionaryLength(Notifications))})
			TweenPositionIn:Play()
			
			TweenPositionIn.Completed:Connect(function()
				local TweenSize = tweenService:Create(Notification["6"], TweenInfo.new(Delay, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 1)})

				TweenSize:Play()
				
				TweenSize.Completed:Connect(function()
					Notification:Destroy()
				end)
			end)		
		end
		
		Notification:Update()
		
		Notifications[NotificationFrame] = NotificationFrame
		
		return Notification
	end
end

return Library;

--[[
local Main = Library:Window({Name = "Preview Menu", Side = "Center", KeybindList = true, Watermark = true, Indicators = true})

local MainTab = Main:CreateTab({Name = "Main", Icon = "rbxassetid://16863175349"})
local UniversalTab = Main:CreateTab({Name = "Universal", Icon = "rbxassetid://16866569883"})
local VisualsTab = Main:CreateTab({Name = "Visuals", Icon = "rbxassetid://16863266011"})
local MiscTab = Main:CreateTab({Name = "Misc", Icon = "rbxassetid://16864702418"})
local SkinsTab = Main:CreateTab({Name = "Skins", Icon = "rbxassetid://16866165737"})
local PlayersTab = Main:CreateTab({Name = "Players", Icon = "rbxassetid://16863267075", PlayerList = true})
local SettingsTab = Main:CreateTab({Name = "Settings", Icon = "rbxassetid://16863267906"})

local SettingsUI = SettingsTab:Section({Name = "UI"})
local Section = MainTab:Section()

local Button = Section:Button()
Section:Label()
local Toggle = Section:Toggle()
Toggle:Keybind({Default = "Q"})

local Toggle2 = Section:Toggle()
Toggle2:Keybind({Default = "E", Mode = "Hold"})

local Toggle3 = Section:Toggle()
Toggle3:Keybind({Default = "F", Mode = "Off Hold"})

Section:Slider()
local Drop = Section:Dropdown({Content = {"Option 1", "Option 2", "Option 3"}, Default = "Option 1"})

local WatermarkToggle = SettingsUI:Toggle({Name = "Watermark", Callback = function() Main:WatermarkVisibility() end})
local KeybindListToggle = SettingsUI:Toggle({Name = "Keybind List", Callback = function() Main:KeybindListVisibility() end})
local IndicatorToggle = SettingsUI:Toggle({Name = "Indicators", Callback = function() Main:IndicatorVisibility() end})
local TestButton = SettingsUI:Button({Name = "Notification Test", Callback = function()
	Library:Notify("Test Notification", 2)
end})

Library:Init()]]
