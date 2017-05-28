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
            
            % decide to slow down, compute the required force of brake
            if dist >= 0 && dist < 2 && isequal(light, traffLight.RED)
                acc = simUtils.requiredAccToStop(vehicle.velocity, dist-0.8);
                agent.popState();
                agent.pushState(slowDownState(acc));
            end
        end
    end
end