classdef advstate < handle
    
    properties (Abstract)
        name
    end
    
    methods (Abstract)
        update(this, agent, env, vehicle)
    end
end