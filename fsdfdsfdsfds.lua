local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local uis = game:GetService("UserInputService")

local viewport = workspace.CurrentCamera.ViewportSize
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local Library = {
	Flags = {},
	UnnamedFlags = 0,
}

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
function Library:NewFlag()
	Library.UnnamedFlags += 1
	--
	return tostring(Library.UnnamedFlags)
end
--
function Library:Window(options)
	options = Library:Validate({
		Name = "UI Library"
	}, options or {})

	local GUI = {
		CurrentTab = nil,
		CurrentPlayer = nil,
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

		-- StarterGui.MyLibrary.MainBackground.UIStroke
		GUI["3"] = Instance.new("UIStroke", GUI["2"]);
		GUI["3"]["Color"] = Color3.fromRGB(11, 11, 11);
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
		GUI["59"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		GUI["59"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		GUI["59"]["TextSize"] = 14;
		GUI["59"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
		GUI["59"]["Size"] = UDim2.new(0.5, 0, 0, 25);
		GUI["59"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
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

	function GUI:CreateTab(options)
		options = Library:Validate({
			Name = "Main",
			Icon = "rbxassetid://16863175349",
			PlayerList = false
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
				Tab["7"]["Size"] = UDim2.new(1, -24, 1, 2);
				Tab["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Tab["7"]["Position"] = UDim2.new(0, 12, 0, -14);
				Tab["7"]["Name"] = [[Tab]];
				Tab["7"]["Visible"] = false;
			end

			if options.PlayerList == false then
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
				Tab["a"]["PaddingTop"] = UDim.new(0, 1);
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
				Tab["43"]["PaddingTop"] = UDim.new(0, 1);
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
				PlayerListTab["5"]["Size"] = UDim2.new(1, -24, 1, 2);
				PlayerListTab["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["5"]["Position"] = UDim2.new(0, 12, 0, -14);
				PlayerListTab["5"]["Name"] = [[PlayerTab]];
				
				PlayerListTab["5a"] = Instance.new("UIPadding", PlayerListTab["5"]);
				PlayerListTab["5a"]["PaddingTop"] = UDim.new(0, 15);

				
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

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSettings.TopBar.Bar
				PlayerListTab["b"] = Instance.new("Frame", PlayerListTab["8"]);
				PlayerListTab["b"]["BorderSizePixel"] = 0;
				PlayerListTab["b"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
				PlayerListTab["b"]["Size"] = UDim2.new(1, -6, 0, 1);
				PlayerListTab["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["b"]["Position"] = UDim2.new(0, 3, 1, -1);
				PlayerListTab["b"]["Name"] = [[Bar]];

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
				PlayerListTab["15"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

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
				PlayerListTab["1e"]["Size"] = UDim2.new(1, 0, 0.5, 0);
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
				PlayerListTab["20"]["Text"] = "Player List - [".. #players:GetPlayers() .. "] Players";
				PlayerListTab["20"]["Name"] = [[Title]];
				PlayerListTab["20"]["BackgroundTransparency"] = 1;

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.TopBar.Title.UIPadding
				PlayerListTab["21"] = Instance.new("UIPadding", PlayerListTab["20"]);
				PlayerListTab["21"]["PaddingLeft"] = UDim.new(0, 5);

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.TopBar.Bar
				PlayerListTab["22"] = Instance.new("Frame", PlayerListTab["1f"]);
				PlayerListTab["22"]["BorderSizePixel"] = 0;
				PlayerListTab["22"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
				PlayerListTab["22"]["Size"] = UDim2.new(1, -6, 0, 1);
				PlayerListTab["22"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["22"]["Position"] = UDim2.new(0, 3, 1, -1);
				PlayerListTab["22"]["Name"] = [[Bar]];

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
				PlayerListTab["5g"]["PaddingTop"] = UDim.new(0, 4);

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.UIStroke
				PlayerListTab["2b"] = Instance.new("UIStroke", PlayerListTab["1e"]);
				PlayerListTab["2b"]["Color"] = Color3.fromRGB(27, 27, 27);
				
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.ScrollBarBack
				PlayerListTab["2b"] = Instance.new("Frame", PlayerListTab["1e"]);
				PlayerListTab["2b"]["BorderSizePixel"] = 0;
				PlayerListTab["2b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				PlayerListTab["2b"]["AnchorPoint"] = Vector2.new(1, 0);
				PlayerListTab["2b"]["BackgroundTransparency"] = 1;
				PlayerListTab["2b"]["Size"] = UDim2.new(0, 6, 1, -25);
				PlayerListTab["2b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				PlayerListTab["2b"]["Position"] = UDim2.new(1, -3, 0, 25);
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
						PlayerListTab["13"].Text = string.format("Health : %s/%s", Humanoid.Health, Humanoid.MaxHealth)
						PlayerListTab["11"].Visible = false
						PlayerListTab["10"].Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%s&width=420&height=420&format=png", TargetPlayer.UserId)
					else
						PlayerListTab["9"].Text = "Players - Settings"
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
						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.PlayerFrame
						Item["25"] = Instance.new("Frame", PlayerListTab["24"]);
						Item["25"]["BorderSizePixel"] = 0;
						Item["25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["25"]["BackgroundTransparency"] = 1;
						Item["25"]["Size"] = UDim2.new(1, 0, 0, 15);
						Item["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["25"]["Name"] = Player.Name;
						Item["25"]["LayoutOrder"] = 1;

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.PlayerFrame.PlayerName
						Item["26"] = Instance.new("TextLabel", Item["25"]);
						Item["26"]["BorderSizePixel"] = 0;
						Item["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["26"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Item["26"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Item["26"]["TextSize"] = 17;
						Item["26"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
						Item["26"]["Size"] = UDim2.new(0.33000001311302185, 0, 1, 0);
						Item["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["26"]["Text"] = Player.Name;
						Item["26"]["Name"] = [[PlayerName]];
						Item["26"]["BackgroundTransparency"] = 1;

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.PlayerFrame.PlayerName.UIPadding
						Item["27"] = Instance.new("UIPadding", Item["26"]);
						Item["27"]["PaddingLeft"] = UDim.new(0, 10);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.PlayerFrame.Team
						Item["28"] = Instance.new("TextLabel", Item["25"]);
						Item["28"]["BorderSizePixel"] = 0;
						Item["28"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["28"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Item["28"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Item["28"]["TextSize"] = 17;
						Item["28"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
						Item["28"]["Size"] = UDim2.new(0.33000001311302185, 0, 1, 0);
						Item["28"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["28"]["Text"] = Player.Team ~= nil and Player.Team or "None";
						Item["28"]["Name"] = [[Team]];
						Item["28"]["BackgroundTransparency"] = 1;
						Item["28"]["Position"] = UDim2.new(0.33000001311302185, 0, 0, 0);
						
						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerItem.PlayerListSection.PlayerList.PlayerFrame.Flags
						Item["29"] = Instance.new("TextLabel", Item["25"]);
						Item["29"]["BorderSizePixel"] = 0;
						Item["29"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["29"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Item["29"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Item["29"]["TextSize"] = 17;
						Item["29"]["TextColor3"] = Color3.fromRGB(255, 0, 255);
						Item["29"]["Size"] = UDim2.new(0.33000001311302185, 0, 1, 0);
						Item["29"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["29"]["Text"] = [[Local Player]];
						Item["29"]["Name"] = [[Flags]];
						Item["29"]["BackgroundTransparency"] = 1;
						Item["29"]["Position"] = UDim2.new(0.6600000262260437, 0, 0, 0);
					else
						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.PlayerFrame
						Item["25"] = Instance.new("Frame", PlayerListTab["24"]);
						Item["25"]["BorderSizePixel"] = 0;
						Item["25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["25"]["BackgroundTransparency"] = 1;
						Item["25"]["Size"] = UDim2.new(1, 0, 0, 15);
						Item["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["25"]["Name"] = Player.Name;
						Item["25"]["LayoutOrder"] = 2;

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.PlayerFrame.PlayerName
						Item["26"] = Instance.new("TextLabel", Item["25"]);
						Item["26"]["BorderSizePixel"] = 0;
						Item["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["26"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Item["26"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Item["26"]["TextSize"] = 17;
						Item["26"]["TextColor3"] = Color3.fromRGB(216, 216, 216);
						Item["26"]["Size"] = UDim2.new(0.33000001311302185, 0, 1, 0);
						Item["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["26"]["Text"] = Player.Name;
						Item["26"]["Name"] = [[PlayerName]];
						Item["26"]["BackgroundTransparency"] = 1;

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.PlayerFrame.PlayerName.UIPadding
						Item["27"] = Instance.new("UIPadding", Item["26"]);
						Item["27"]["PaddingLeft"] = UDim.new(0, 10);

						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerTab.PlayerListSection.PlayerList.PlayerFrame.Team
						Item["28"] = Instance.new("TextLabel", Item["25"]);
						Item["28"]["BorderSizePixel"] = 0;
						Item["28"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["28"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Item["28"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Item["28"]["TextSize"] = 17;
						Item["28"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
						Item["28"]["Size"] = UDim2.new(0.33000001311302185, 0, 1, 0);
						Item["28"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["28"]["Text"] = Player.Team ~= nil and Player.Team or "None";
						Item["28"]["Name"] = [[Team]];
						Item["28"]["BackgroundTransparency"] = 1;
						Item["28"]["Position"] = UDim2.new(0.33000001311302185, 0, 0, 0);
						
						-- StarterGui.MyLibrary.MainBackground.ContentContainer.PlayerItem.PlayerListSection.PlayerList.PlayerFrame.Flags
						Item["29"] = Instance.new("TextLabel", Item["25"]);
						Item["29"]["BorderSizePixel"] = 0;
						Item["29"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						Item["29"]["TextXAlignment"] = Enum.TextXAlignment.Left;
						Item["29"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
						Item["29"]["TextSize"] = 17;
						Item["29"]["TextColor3"] = Color3.fromRGB(214, 214, 214);
						Item["29"]["Size"] = UDim2.new(0.33000001311302185, 0, 1, 0);
						Item["29"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						Item["29"]["Text"] = [[None]];
						Item["29"]["Name"] = [[Flags]];
						Item["29"]["BackgroundTransparency"] = 1;
						Item["29"]["Position"] = UDim2.new(0.6600000262260437, 0, 0, 0);
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
			end

			-- Logic
			do
				for _, Player in pairs(players:GetPlayers()) do
					PlayerListTab:AddPlayer(Player)
				end

				players.PlayerAdded:Connect(function(Player)
					PlayerListTab:AddPlayer(Player)
				end)

				players.PlayerRemoving:Connect(function(Player)
					PlayerListTab:RemnovePlayer(Player)
				end)
				
				
				PlayerListTab["2c"].MouseEnter:Connect(function()
					PlayerListTab.test = true
					game:GetService("ContextActionService"):BindAction("disable_mouse_input", function()
						return Enum.ContextActionResult.Sink
					end, false, Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3, Enum.UserInputType.MouseWheel)
				end)

				PlayerListTab["2c"].MouseLeave:Connect(function()
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
					local max_players = 32
					local max_bars = math.floor((PlayerListTab["23"].AbsoluteSize.Y + 94 - 194) / (18 + 4))
					max_players = max_players - max_bars
					
					local function scroll(amount)
						PlayerListTab.CurrentScroll = math.clamp(amount, 0, max_players)

						if PlayerListTab.CurrentScroll > 0 then
							PlayerListTab["24"].Position = UDim2.new(0, 0, 0, PlayerListTab.CurrentScroll * -18 - ((PlayerListTab.CurrentScroll) * 4))
						else
							PlayerListTab["24"].Position = UDim2.new(0, 0, 0, 0)
						end

						PlayerListTab["2c"].Position = UDim2.new(0, 0, (1 / (max_players + 1)) * PlayerListTab.CurrentScroll)
					end

					local function update_scroll(input)
						local sizeY = math.clamp((input.Position.Y - PlayerListTab["2b"].AbsolutePosition.Y - game:GetService("GuiService"):GetGuiInset().Y) / PlayerListTab["2b"].AbsoluteSize.Y, 0, 0.4)
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

					PlayerListTab["2c"].InputChanged:Connect(function(input)
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
		
		function Tab:Section(options)
			options = Library:Validate({
				Name = "Test",
				Side = "Left"
			}, options or {})
			
			local Section = {}
			

			do -- Section
				-- StarterGui.MyLibrary.MainBackground.ContentContainer.HomeSection.Left.Section
				Section["9"] = Instance.new("Frame", Tab["7"]);
				Section["9"]["BorderSizePixel"] = 0;
				Section["9"]["BackgroundColor3"] = Color3.fromRGB(20, 20, 20);
				Section["9"]["Size"] = UDim2.new(1, 0, 0, 30);
				Section["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Section["9"]["Name"] = [[Section]];
				Section["9"]["AutomaticSize"] = Enum.AutomaticSize.XY;

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

				-- StarterGui.MyLibrary.MainBackground.ContentContainer.HomeSection.Left.Section.TopBar.Bar
				Section["e"] = Instance.new("Frame", Section["b"]);
				Section["e"]["BorderSizePixel"] = 0;
				Section["e"]["BackgroundColor3"] = Color3.fromRGB(0, 255, 0);
				Section["e"]["Size"] = UDim2.new(1, -6, 0, 1);
				Section["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Section["e"]["Position"] = UDim2.new(0, 3, 1, -1);
				Section["e"]["Name"] = [[Bar]];

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
				Section["14"]["PaddingTop"] = UDim.new(0, 10);
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
				
				do -- Methods
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
						end
						
						Library.Flags[options.Flag] = Toggle.State
						options.Callback(Toggle.State)
					end
				end

				do -- Logic
					Toggle["35"].MouseEnter:Connect(function()
						Toggle.Hover = true

						Library:tween(Toggle["39"], {Color = Color3.fromRGB(55, 55, 55)})
					end)

					Toggle["35"].MouseLeave:Connect(function()
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
							
							options.Callback(Toggle.State)
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
					Default = options.Min or 1,
					Flag = Library.NewFlag(),
					Callback = function(v) print(v) end
				}, options or {})
				

				local Slider = {
					Hover = false,
					MouseDown = false,
					Connection = nil,
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
					Slider["19"]["TextSize"] = 12;
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
				
				do -- Methods
					function Slider:SetValue(v)
						if v == nil then
							local percentage = math.clamp((uis:GetMouseLocation().X - Slider["1b"].AbsolutePosition.X) / (Slider["1b"].AbsoluteSize.X), 0, 1)
							local value = math.floor(((options.Max - options.Min) * percentage) + options.Min)
							
							Slider["19"].Text = tostring(value)
							tweenService:Create(Slider["1d"], TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromScale(percentage, 1)}):Play()
						else
							Slider["19"].Text = tostring(v)
							tweenService:Create(Slider["1d"], TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.fromScale(((v - options.Min) / (options.Max - options.Min)), 1)}):Play()
						end
						
						Library.Flags[options.Flag] = Slider:GetValue()
						options.Callback(Slider:GetValue())
					end
					
					function Slider:GetValue()
						return tonumber(Slider["19"].Text)
					end
				end
				
				Slider:SetValue(options.Default)
				
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
							
							if not Slider.Connection then
								Slider.Connection = runService.RenderStepped:Connect(function()
									Slider:SetValue()
								end)
							end
						end
					end)

					uis.InputEnded:Connect(function(input, gpe)
						if gpe then return end

						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							Slider.MouseDown = false

							if Slider.Hover then

							else

							end
							
							if Slider.Connection then Slider.Connection:Disconnect() end
							Slider.Connection = nil
						end
					end)
				end
				
				return Slider
			end
			
			function Section:Dropdown(options)
				options = Library:Validate({
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
					Dropdown["c2"]["Text"] = [[Option]];
					Dropdown["c2"]["Name"] = [[Option]];
					Dropdown["c2"]["BackgroundTransparency"] = 1;

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
					Dropdown["c5"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25);
					Dropdown["c5"]["Visible"] = false;
					Dropdown["c5"]["Size"] = UDim2.new(1, 0, 0, 22);
					Dropdown["c5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Dropdown["c5"]["Position"] = UDim2.new(0, 0, 1, 0);
					Dropdown["c5"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					Dropdown["c5"]["Name"] = [[Background]];

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
							
							if Dropdown.Items[id] ~= nil then
								return
							end
							
							Dropdown.Items[id] = {
								instance = {},
								value = value
							}
							
							-- StarterGui.MyLibrary.MainBackground.ContentContainer.Hometab.Right.Section.ContentContainer.DropdownOpen.Options.Background.Inactive
							Item["c7"] = Instance.new("Frame", Dropdown["c5"]);
							Item["c7"]["BorderSizePixel"] = 0;
							Item["c7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
							Item["c7"]["BackgroundTransparency"] = 1;
							Item["c7"]["Size"] = UDim2.new(1, 0, 0, 18);
							Item["c7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Item["c7"]["Name"] = [[Inactive]];

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

local Main = Library:Window({Name = "LuckyHub"})

local MainTab = Main:CreateTab({Name = "Main", Icon = "rbxassetid://16863175349"})
local UniversalTab = Main:CreateTab({Name = "Universal", Icon = "rbxassetid://16866569883"})
local VisualsTab = Main:CreateTab({Name = "Visuals", Icon = "rbxassetid://16863266011"})
local VisualsTab = Main:CreateTab({Name = "Misc", Icon = "rbxassetid://16864702418"})
local VisualsTab = Main:CreateTab({Name = "Skins", Icon = "rbxassetid://16866165737"})
local PlayersTab = Main:CreateTab({Name = "Players", Icon = "rbxassetid://16863267075", PlayerList = true})
local SettingsTab = Main:CreateTab({Name = "Settings", Icon = "rbxassetid://16863267906"})

local Section = MainTab:Section()
local Button = Section:Button()
Section:Label()
Section:Toggle()
Section:Slider()
local Drop = Section:Dropdown({Content = {"Option 1", "Option 2"}})

Library:Init()
