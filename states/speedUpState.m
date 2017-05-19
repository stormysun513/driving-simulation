classdef speedUpState < advstate
    
    properties
        name = 'speedUpState'
    end
    
    methods
        function this = speedUpState(varargin)
        end
        
        function update(this, agent, env, vehicle)
            
            % accelerate
            dir = vehicle.orientation;
            a = dir/norm(dir)*agent.max_acc;
            t = agent.interval;
            xi = vehicle.position;
            vi = vehicle.velocity;
            vf = vi + a*t;
            vf_norm = norm(vf);
            vf_unit = vf/vf_norm;
            xf = xi + vi*t + 0.5*a*t*t;
            
            if vf_norm > agent.max_speed
                vf = vf_unit*agent.max_speed;
            end
            
            vehicle.position = xf;
            vehicle.velocity = vf;
            vehicle.orientation = vf_unit;
            
            if vf_norm >= agent.max_speed
                agent.popState();
                agent.pushState(fixSpeedState());
            end
        end
    end
end