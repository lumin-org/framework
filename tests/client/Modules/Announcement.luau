local PlayerService = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = PlayerService.LocalPlayer

local Lumin = require(ReplicatedStorage.framework.src)

local Announcement = {
    UI = {}
}

function Announcement.Heartbeat(delta)
    print(delta)
end

function Announcement.Init()
	Announcement.UI.Gui = Player.PlayerGui:WaitForChild("Announce")
	Announcement.UI.Label = Announcement.UI.Gui:WaitForChild("AnnounceLabel")
end

return Lumin.New(Announcement)
