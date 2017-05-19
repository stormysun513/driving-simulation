classdef fixSpeedState < advstate
    
    properties
        name = 'fixSpeedState'
    end
    
    methods
        
        function this = fixSpeedState(varargin)
        end
        
        function update(~, agent, env, vehicle)
            
            % update position
            vehicle.position = vehicle.position + ...
                vehicle.velocity*agent.interval;
            
            dist = env.getIntersectDist(vehicle);
            light = env.getLightStatus();
            
            if dist >= 0 && dist < 2 && isequal(light, traffLight.RED)
                agent.popState();
                agent.pushState(slowDownState());
            end
        end
    end
end