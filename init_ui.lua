--[[
OKAY like a sidenote before all the code starts.. 
this is a very long script just to make ui 
cause i actually design ui outside of exploiting 
so i guess you could call me "professional" but

if you manage to deobfuscate all this congrats
dont open this to skids cause you know we both hate them.
thanks <3

THIS WAS SO CANCEROUS TO DO BY HAND
]]

local ui = {}

local emptystring = ""

local theme = {}
theme.color1 = Color3.fromRGB(56, 57, 68)

local colors = {}
colors.black = Color3.new(0, 0, 0)
colors.white = Color3.new(1, 1, 1)
colors.red = Color3.fromRGB(200, 100, 100)
colors.blue = Color3.fromRGB(100, 150, 200)

local udim = {}
udim.half = UDim2.new(0.5, 0, 0.5, 0)
udim.full = UDim2.new(1, 0, 1, 0)

local anchor = {}
anchor.half = Vector2.new(0.5, 0.5)
anchor.full = Vector2.new(1, 1)

local rainbow = ColorSequence.new{ -- weee
	ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),
	ColorSequenceKeypoint.new(0.16, Color3.new(1, 1, 0)),
	ColorSequenceKeypoint.new(0.32, Color3.new(0, 1, 0)),
	ColorSequenceKeypoint.new(0.48, Color3.new(0, 1, 1)),
	ColorSequenceKeypoint.new(0.64, Color3.new(0, 0, 1)),
	ColorSequenceKeypoint.new(0.82, Color3.new(1, 0, 1)),
	ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
}

gui = Instance.new("ScreenGui")

local frame = Instance.new("Frame")
local window = Instance.new("ScrollingFrame")
window.ClipsDescendants = true
window.BorderSizePixel = 0
window.BackgroundTransparency = 1
window.ScrollBarThickness = 5
window.ScrollBarImageTransparency = 0.7
window.TopImage = "rbxassetid://5255460787"
window.MidImage = "rbxassetid://6347925"
window.BottomImage = "rbxassetid://5255459942"

local image = Instance.new("ImageLabel")
image.Image = emptystring
image.ImageTransparency = 1

local button = Instance.new("ImageButton")
button.AutoButtonColor = false

local textwindow = Instance.new("TextBox")
textwindow.BackgroundTransparency = 1
textwindow.ClearTextOnFocus = true
textwindow.Font = Enum.Font.SourceSansSemibold
textwindow.PlaceholderColor3 = Color3.fromRGB(79, 80, 88)
textwindow.PlaceholderText = "Type a command..."
textwindow.Text = emptystring
textwindow.TextSize = 19
textwindow.TextColor3 = colors.white
textwindow.TextXAlignment = Enum.TextXAlignment.Left
textwindow.TextYAlignment = Enum.TextYAlignment.Bottom

local text = Instance.new("TextLabel")

local grid = Instance.new("UIGridLayout")
local list = Instance.new("UIListLayout")

local ratio = Instance.new("UIAspectRatioConstraint")
local constraint = Instance.new("UISizeConstraint")
constraint.Name = "constraint"

local round = Instance.new("UICorner")
local gradient = Instance.new("UIGradient")
local outline = Instance.new("UIStroke")


local rgb = outline:Clone()
local rgb_gradient = gradient:Clone()

rgb.Name = "rgb"

rgb.Thickness = 0.6 -- anything more than 0.5
rgb.Color = colors.white

rgb_gradient.Color = rainbow
rgb_gradient.Parent = rgb


local shadow = frame:Clone()
shadow.Name = "shadow"
shadow.AnchorPoint = anchor.half
shadow.Position = udim.half
shadow.Size = UDim2.new(1, 10, 1, 10) -- +10 pixels for shadow

shadow.Style = Enum.FrameStyle.DropShadow


theme.gradient = gradient:Clone()
theme.gradient.Name = "gradient"
theme.gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, colors.white),
	ColorSequenceKeypoint.new(0.28, colors.white),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 237, 237))
}

local sample_result = button:Clone()
local sr_shadow = image:Clone()
local src_corner = round:Clone()
local sr_title = text:Clone()
sample_result.Name = "sample"
sample_result.BackgroundTransparency = 1

sr_shadow.Name = "shadow"
sr_shadow.AnchorPoint = anchor.half
sr_shadow.BackgroundColor3 = colors.black
sr_shadow.BackgroundTransparency = 0.85
sr_shadow.Position = udim.half
sr_shadow.Size = UDim2.new(1, -5, 1, -5)

sr_title.Name = "title"
sr_title.AnchorPoint = anchor.half
sr_title.BackgroundTransparency = 1
sr_title.Position = udim.half
sr_title.Size = UDim2.new(1, -10, 1, -5)

sr_title.Font = Enum.Font.SourceSansSemibold
sr_title.TextColor3 = colors.white
sr_title.TextScaled = true
sr_title.TextTransparency = 0.8
sr_title.TextWrapped = true
sr_title.TextXAlignment = Enum.TextXAlignment.Left
sr_title.TextYAlignment = Enum.TextYAlignment.Center

src_corner.CornerRadius = UDim.new(0, 5)

sr_shadow.Parent = sample_result
src_corner.Parent = sr_shadow
sr_title.Parent = sample_result

function ui.create_searchbar()
	local search_round = round:Clone()
	local searchbar = frame:Clone()
	local bar = textwindow:Clone()
	local search_icon = image:Clone()
	local searchicon_ratio = ratio:Clone()

	-- FRAME
	searchbar.Name = "search"
	searchbar.BackgroundColor3 = colors.black
	searchbar.BackgroundTransparency = 0.75

	searchbar.Size = UDim2.new(0.92, -10, 0, 25)
	searchbar.ClipsDescendants = true
	
	bar.AnchorPoint = Vector2.new(0, 0.5)
	bar.Position = UDim2.new(0, 30, 0.5, 0)
	bar.Size = UDim2.new(1, -10, 1, -7)
	
	search_icon.BackgroundTransparency = 1
	search_icon.AnchorPoint = Vector2.new(0, 0.5)
	search_icon.Position = UDim2.new(0, 2, 0.5, 0)
	search_icon.Size = udim.full
	search_icon.Image = "rbxassetid://8377210913"
	search_icon.ImageTransparency = 0
	search_icon.ImageColor3 = Color3.fromRGB(79, 80, 88)
	search_icon.ScaleType = Enum.ScaleType.Fit

	search_round.CornerRadius = UDim.new(0, 4)
	searchicon_ratio.AspectRatio = 1

	bar.Parent = searchbar
	search_icon.Parent = searchbar
	searchicon_ratio.Parent = search_icon
	search_round.Parent = searchbar
	
	return searchbar
end

function ui.create_button()
	local circle = button:Clone()
	local circle_round = round:Clone()
	local circle_ratio = ratio:Clone()

	circle.Size = udim.full
	circle_round.CornerRadius = UDim.new(1, 0)
	circle_ratio.AspectRatio = 1

	circle_round.Parent = circle
	circle_ratio.Parent = circle

	return circle
end

function ui.create_tab(logo) -- gaddam this is longer than...
	logo = logo or false

	local tab = frame:Clone()
	local buttons = frame:Clone()
	local buttons_sorting = grid:Clone()
	local tab_logo = image:Clone()
	local title
	local status = text:Clone()
	if logo then
		title = text:Clone()
	end

	-- TAB
	tab.Name = "tab"
	tab.Size = UDim2.new(1, 0, 0, 25)

	tab.BackgroundTransparency = 1

	tab.ClipsDescendants = true

	-- BUTTONS
	buttons.Name = "buttons"
	buttons.AnchorPoint = Vector2.new(1, 0)

	buttons.Size = UDim2.new(1, -7, 1, 0)
	buttons.Position = UDim2.new(1, -7, 0, 0)

	buttons.BackgroundTransparency = 1

	buttons.ClipsDescendants = true

	buttons_sorting.Name = "layout"
	buttons_sorting.CellPadding = UDim2.new(0, 5, 0, 0)
	buttons_sorting.CellSize = UDim2.new(0, 13, 0.5, 0)

	buttons_sorting.SortOrder = Enum.SortOrder.LayoutOrder
	buttons_sorting.FillDirection = Enum.FillDirection.Horizontal
	buttons_sorting.HorizontalAlignment = Enum.HorizontalAlignment.Right
	buttons_sorting.VerticalAlignment = Enum.VerticalAlignment.Center

	buttons_sorting.Parent = buttons

	-- TAB_LOGO
	tab_logo.Name = "title"
	tab_logo.AnchorPoint = anchor.half

	tab_logo.Size = udim.full
	tab_logo.Position = udim.half

	tab_logo.BackgroundTransparency = 1

	--tab_logo.Image = emptystring

	if logo then
		-- STATUS
		status.Size = UDim2.new(1, -77, 0.5, 0)
		status.Position = UDim2.new(0, 77, 0, 0)

		status.BackgroundTransparency = 1

		status.Font = Enum.Font.Ubuntu

		status.TextColor3 = colors.white
		status.TextTransparency = 0.7

		status.TextScaled = true
		status.TextWrapped = true

		status.TextXAlignment = Enum.TextXAlignment.Left
		status.TextYAlignment = Enum.TextYAlignment.Top

		-- TITLE
		title.Size = UDim2.new(1, 0, 0.9, 0)
		title.Position = UDim2.new(0, 5, 0, 0)

		title.BackgroundTransparency = 1

		title.Font = Enum.Font.RobotoMono

		title.TextColor3 = colors.white

		title.TextScaled = true
		title.TextWrapped = true

		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextYAlignment = Enum.TextYAlignment.Top

		title.Text = "Mercury" -- executor title but like dont change this ####### :/

		title.Parent = tab_logo
	else
		-- STATUS
		status.Size = UDim2.new(1, -2, 0.5, 0)
		status.Position = UDim2.new(0, 2, 0, 0)

		status.BackgroundTransparency = 1

		status.Font = Enum.Font.Ubuntu

		status.TextColor3 = colors.white
		status.TextTransparency = 0.7

		status.TextScaled = true
		status.TextWrapped = true

		status.TextXAlignment = Enum.TextXAlignment.Left
		status.TextYAlignment = Enum.TextYAlignment.Top
	end

	status.Name = "status"

	-- PARENTING
	buttons.Parent = tab
	tab_logo.Parent = tab
	status.Parent = tab_logo

	return tab
end

function ui.create_panel()
	local panel = frame:Clone()
	local panel_tab = ui.create_tab(true)

	-- fancys
	local dropshadow = shadow:Clone()
	local panel_round = round:Clone()
	local streak = theme.gradient:Clone()
	local panel_rgb = rgb:Clone()

	-- PANEL
	panel.BackgroundColor3 = theme.color1
	panel.BorderSizePixel = 0
	panel.ZIndex = 0

	-- DROPSHADOW
	dropshadow.ZIndex = -1 -- ASFHUIHUIAWFbawuirfbuiwafbuiawfbuiawbuifawbuifbiawfhjdbsfukgawetyfegawb aefgwey uigfyuewgfyuawegfy uWE

	-- ROUND
	panel_round.CornerRadius = UDim.new(0, 3)

	-- RGB
	panel_rgb.Enabled = false

	-- PARENTING
	panel_tab.Parent = panel
	dropshadow.Parent = panel
	panel_round.Parent = panel
	streak.Parent = panel
	panel_rgb.Parent = panel

	return panel
end

-- menu
local menu = ui.create_panel()
local menu_frame = window:Clone()
local window_grid = grid:Clone()
local searchbar = ui.create_searchbar()
local menu_sample = sample_result:Clone()

local menu_size = constraint:Clone()
local close = ui.create_button()
local button_settings = ui.create_button()
local _settings = button:Clone()

menu.Size = UDim2.new(0, 400, 0, 250)
menu.Position = udim.half

menu_size.MinSize = Vector2.new(150, 50)

menu["gradient"].Rotation = 127

-- buttons
close.Name = "close"
close.BackgroundColor3 = colors.red

button_settings.Name = "settings"
button_settings.BackgroundColor3 = colors.blue
button_settings.LayoutOrder = -1

close.Parent = menu["tab"]["buttons"]
button_settings.Parent = menu["tab"]["buttons"]

-- window
menu_frame.Size = UDim2.new(1, -10, 1, -50)

menu_frame.AnchorPoint = anchor.full
menu_frame.Position = udim.full

window_grid.CellSize = UDim2.new(1, -7, 0, 25)
window_grid.FillDirection = Enum.FillDirection.Horizontal
window_grid.HorizontalAlignment = Enum.HorizontalAlignment.Left
window_grid.SortOrder = Enum.SortOrder.Name
window_grid.VerticalAlignment = Enum.VerticalAlignment.Top

-- SEARCHBAR
searchbar.Position = UDim2.new(0, 10, 0, 25)
searchbar.Size = UDim2.new(0.92, -10, 0, 25)

-- PARENTING
menu.Parent = gui
menu_frame.Parent = menu
window_grid.Parent = menu_frame
searchbar.Parent = menu
menu_size.Parent = menu
menu_sample.Parent = menu_frame

--[[-- settings
local menu = ui.create_panel()
local menu_size = constraint:Clone()

menu.Size = UDim2.new(0, 200, 0, 250)
menu.Position = udim.half

menu_size.MaxSize = Vector2.new(200, 9e9)
menu_size.MinSize = Vector2.new(150, 50)

menu["gradient"].Rotation = 22

menu_size.Parent = menu

menu.Parent = gui]]

return ui
