local WaitForSignal = require(script.Parent.WaitForSignal);

return function(instance: Instance, attribute: string, timeout: number)
    local res = instance:GetAttribute(attribute);
    if res then return res; end;

    WaitForSignal(instance:GetAttributeChangedSignal(attribute), timeout);

    return instance:GetAttribute(attribute);
end;