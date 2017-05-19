classdef stopState < advstate
    
    properties
        name = 'stopState'
        wait_time
    end
    
    methods
        function this = stopState(varargin)
            this.wait_time = 0;
        end
        
        function update(~, agent, env, vehicle)
            
            % reduce the velocity to 0
            vehicle.velocity = [0 0];
            
            dist = env.getIntersectDist(vehicle);
            light = env.getLightStatus();
            
            if dist >= 0 && dist < 1
                if light == traffLight.GREEN
                    agent.popState();
                    agent.pushState(speedUpState());
                end
            elseif dist >= 1
                agent.popState();
                agent.pushState(speedUpState());
            end
        end
    end
end