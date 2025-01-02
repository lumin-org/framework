local Lumin = require(game.ReplicatedStorage.framework.src)
local Module3 = require(script.Parent.module3)
print("HI 4")
return Lumin.New({
    Init = function()
        local success, err = pcall(function()
            print((Module3 :: any).Test.Goodbye())
        end)
        print(success, err)
    end
})
