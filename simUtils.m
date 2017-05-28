classdef simUtils
    
    methods (Static)
        % check whether a specified acc is large enough to stop
        function res = isStoppable(velocity, acc, distance)
            v = norm(velocity);
            a = norm(acc);
            braking_distance = v*v/2.0/a;
            res = (braking_distance <= distance);
        end
        
        % return an acc able to stop at a distance with initail velocity v0
        function acc = requiredAccToStop(velocity, distance)
            v = norm(velocity);
            acc = v*v/2/distance;
        end
    end
end