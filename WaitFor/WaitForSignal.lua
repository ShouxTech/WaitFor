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

    local res = {waitSignal:Wait()}; -- Wrapping in table and using table.unpack in return to allow for reading multiple signal arguments.

    -- Using task.defer to prevent a specific task.cancel error from Trove destroy.
    task.defer(function()
        trove:Destroy();
    end);

    return table.unpack(res);
end;
