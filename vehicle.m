classdef vehicle < handle
    
    properties
        position
        orientation
        velocity
    end
    
    methods
        % constructor
        function this = vehicle(varargin)
            this.position = varargin{1};
            this.orientation = varargin{2}/norm(varargin{2});
            this.velocity = varargin{2};
        end
        
        % draw function for vehicles
        function draw(obj)
            r1 = [4/5 -3/5; 3/5 4/5];
            r2 = [4/5 3/5; -3/5 4/5];
            a1 = obj.position+(0.25*r1*obj.orientation')';
            a2 = obj.position+(0.25*r2*obj.orientation')';
            a11 = a1 - 0.4*obj.orientation;
            a22 = a2 - 0.4*obj.orientation;
            
            tmp = [a1; a2; a22; a11; a1];
            plot(tmp(:,1)', tmp(:,2)', 'b', 'LineWidth', 2);
            fill(tmp(:,1)', tmp(:,2)', [0 0.8 0]);
        end
        
        % move function
        function moveStep(obj, step)
            obj.position = obj.position + obj.velocity*step;
        end
    end
    
    methods (Static)
    end
end