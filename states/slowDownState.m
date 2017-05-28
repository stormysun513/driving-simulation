classdef slowDownState < advstate
    
    properties
        name = 'slowDownState'
        brake
    end
    
    methods
        % constructor
        function this = slowDownState(acc)
            this.brake = acc;
        end
        
        % update funciton of slowDownState
        function update(this, agent, env, vehicle)
            
            % accelerate
            dir = -vehicle.orientation;
            a = dir/norm(dir)*this.brake;
            t = agent.interval;
            xi = vehicle.position;
            vi = vehicle.velocity;
            vf = vi + a*t;
            vf_norm = norm(vf);
            xf = xi + vi*t + 0.5*a*t*t;
            
            if vf_norm < 0.1
                vf = [0 0];
            end
            
            vehicle.position = xf;
            vehicle.velocity = vf;
            
            % check whether to change state
            dist = env.getIntersectDist(vehicle);
            light = env.getLightStatus();
            
            if dist >= 0 && dist < 2 && isequal(light, traffLight.GREEN)
                agent.popState();
                agent.pushState(speedUpState());
            elseif isequal(vf, [0 0])
                agent.popState();
                agent.pushState(stopState());
            end
        end
    end
end