local Signal = require(script.Parent.Parent.Signal);
local Trove = require(script.Parent.Parent.Trove);

return function(signal, timeout: number)
    local waitSignal = Signal.new();
    local trove = Trove.new();

    trove:Add(task.delay(timeout, function()
        waitSignal:Fire();
    end));
    trove:Add(signal:Once(function(...)
        waitSignal:Fire(...);
    end));

    local res = waitSignal:Wait();

    trove:Destroy();

    return res;
end;