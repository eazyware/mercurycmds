local _version = "indev"

local client = {}
local world = {}

local _workspace = game:GetService("Workspace")
local inputservice = game:GetService("UserInputService")

local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/eazyware/mercurycmds/main/init_ui.lua"))()--require(script:WaitForChild("ModuleScriptUi"))
local menu = ui.gui:WaitForChild("Frame")

local player = game:GetService("Players").LocalPlayer
local camera = _workspace.CurrentCamera
local mouse = player:GetMouse()

-- ima make these global :troll:
character = player.Character or _workspace[player.Name] or nil
humanoid = character:FindFirstChildOfClass("Humanoid")
root = character["HumanoidRootPart"] or character.PrimaryPart or character:FindFirstChildOfClass("BasePart")

--[[___ ___  __  __ __  __   _   _  _ ___  ___ 
   / __/ _ \|  \/  |  \/  | /_\ | \| |   \/ __|
  | (_| (_) | |\/| | |\/| |/ _ \| .` | |) \__ \
   \___\___/|_|  |_|_|  |_/_/ \_\_|\_|___/|___/]]


commands = {} -- dont manually insert things

function find(_table, e) -- i should not have to do this lmao
	for k, v in pairs(_table) do
		if v == e then
			return k
		end
	end
end

function deepsearch(instance, target)
	for i, v  in pairs(instance:GetDescendants()) do
		if v.Name == target then
			return v
		end
	end
end

function getroot(instance)
	return instance["HumanoidRootPart"] or instance.PrimaryPart or instance:FindFirstChildOfClass("BasePart") or nil
end

function bind(remote, _function) -- easier than doing it manually since i often use
	remote:Connect(_function)
end

function PerFrame(_function)
	for i, v in next, _function do
		game:GetService("RunService"):BindToRenderStep("PerFrame", Enum.RenderPriority.First.Value, commands[find(commands, v)])-- searches through commands table
		--print(v)
	end
end

function ClearPerFrame(name)
	game:GetService("RunService"):UnbindFromRenderStep(name)
end

function forcestate(state)
	for i, v in pairs(Enum.HumanoidStateType.GetEnumItems(Enum.HumanoidStateType)) do -- tables bruhhh
		humanoid:SetStateEnabled(v, false)
	end

	humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true) -- breaks if this doesnt yeah

	humanoid:SetStateEnabled(state, true)
	humanoid:ChangeState(state)
end

function commands.goto(username)
	if game:GetService("Players")[username] then
		target = deepsearch(_workspace, username)

		if game:GetService("Players"):GetPlayerFromCharacter(target) then
			root.CFrame = getroot(target).CFrame
		end
	end
end

function commands.walkspeed(number)
	humanoid.WalkSpeed = number or humanoid.WalkSpeed -- cause if noob puts malformed number
end

function commands.jump_infinite()
	bind(inputservice.JumpRequest, function()
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end)
end

function commands.gravity_no()
	lastgravity = _workspace.Gravity

	if _workspace.Gravity >= 1 then
		_workspace.Gravity = 0
	end
end

function commands.noclip()
	for i, v in next, character:GetDescendants() do -- next cause faster (and i thought all of the loops worked like that but /shrug)
		if v:IsA("BasePart") and v.CanCollide == true then
			v.CanCollide = false
		end
	end
end

function commands.gravity_return()
	_workspace.Gravity = lastgravity

	--[[if _workspace.Gravity == 0 then
		_workspace.Gravity = 196.2
	end]]
end

function commands.swim()
	forcestate(Enum.HumanoidStateType.Swimming)
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
	commands.gravity_no() -- cause you can swim with gravity

	bind(humanoid.Died, commands.gravity_return)
	bind(humanoid.Jumping, function()
		humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end)
end

function commands.density(number)
	local physicalproperties = PhysicalProperties.new(number, 2, 0, 100, 100) -- density, friction, elasticity, frictionWeight, elasticityWeight
	root.CustomPhysicalProperties = physicalproperties
end

function commands.teleport_click()
	bind(mouse.Button1Up, function()
		root.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y + (humanoid.HipHeight + 1), mouse.Hit.Z) -- lower / upper half plus head height
	end)
end


print("cmds ".. _version.. " loaded")


--[[___ _   _ ___ 
   / __| | | |_ _|
  | (_ | |_| || | 
   \___|\___/|___|]]

gui = ui.gui
gui.Parent = (game:GetService("RunService"):IsStudio() and player.PlayerGui or game:GetService("CoreGui")) -- auto parenting // someone else gave me this idk how it works
local window = menu["ScrollingFrame"]
local searchbar = menu["search"]["TextBox"]
local sample_menu = window["sample"]
sample_menu.Visible = false

--[[local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(0, 200, 0, 200)
list.Parent = gui

local sorting = Instance.new("UIGridLayout")

local list_sorting = sorting:Clone()
list_sorting.Parent = list

local bruh = Instance.new("TextLabel")

local textbox = Instance.new("TextBox")
textbox.ClearTextOnFocus = false -- IY couldnt even do this :troll:
textbox.Parent = list]]


--[[ ___ _   _ _  _  ___ _____ ___ ___  _  _   _   _    ___ _______   __
	| __| | | | \| |/ __|_   _|_ _/ _ \| \| | /_\ | |  |_ _|_   _\ \ / /
	| _|| |_| | .` | (__  | |  | | (_) | .` |/ _ \| |__ | |  | |  \ V / 
	|_|  \___/|_|\_|\___| |_| |___\___/|_|\_/_/ \_\____|___| |_|   |_| ]]

function execute(_string)
	command = string.split(_string, " ") -- splits based on whitespace_space
	command_parameters = {}
	
	for i = 2, #command do
		table.insert(command_parameters, command[i]) -- inserting parameters
	end

	if commands[command[1]] then -- if function exists
		pcall(commands[command[1]], unpack(command_parameters)) return -- pcall to prevent error, then unpacks table of parameters (can be left empty)
	end
end

function scanlist(_string)
	local found = {} -- using "index" helps me understand :)

	for index, v in next, commands do -- next for extra "speed"! 
		if string.find(index, _string) then
			table.insert(found, index)
		end
	end

	return found
end

searchbar.Changed:Connect(function()
	print(scanlist(searchbar.ContentText))
end)

bind(inputservice.InputBegan, function(input)
	--if textbox:IsFocused() then -- spaghetti
	if input.KeyCode == Enum.KeyCode.Return then -- return = enter key :/
		execute(searchbar.ContentText)
	end
	--end
end)

for i, v in pairs(commands) do
	clone = sample_menu:Clone()
	clone.Name = i
	clone["title"].Text = " • ".. i -- dot is a bulletpoint
	
	clone.Visible = true
	clone.Parent = window
end
