-- Based off of https://devforum.roblox.com/t/waitfor-easier-handling-of-multiple-events/340851.

local Signal = require(script.Parent.Parent.Signal);
local Trove = require(script.Parent.Parent.Trove);

return function(...)
	local anySignal = Signal.new();
    local trove = Trove.new();

	local signals = {...};
	for _, signal in signals do
		trove:Add(signal:Connect(function(...)
            trove:Destroy();
			anySignal:Fire(signal, ...); -- Fire the final signal with the original signal that was fired and the arguments it was fired with.
		end));
	end;

	return anySignal:Wait();
end;