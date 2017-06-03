classdef traffLight < handle
    
    properties
        x
        y
        h_value
        v_value
        elapsed
        interval
    end
    
    properties (Constant)
        RED = [1 0 0];
        GREEN = [0 1 0];
    end
    
    methods
        
        function this = traffLight(varargin)
            this.x = varargin{1}(1);
            this.y = varargin{1}(2);
            
            if nargin > 1
                this.interval = varargin{2};
            else
                this.interval = 5;
            end
            
            if nargin > 2
                this.elapsed = varargin{3};
            else
                this.elapsed = 0;
            end
            
            this.h_value = traffLight.GREEN;
            this.v_value = traffLight.RED;
        end
        
        function update(this, delta)
            time = this.elapsed + delta;
            if time >= this.interval
                % switch state
                if this.h_value == traffLight.GREEN
                    this.h_value = traffLight.RED;
                    this.v_value = traffLight.GREEN;
                else
                    this.h_value = traffLight.GREEN;
                    this.v_value = traffLight.RED;
                end
                this.elapsed = mod(time, this.interval);
            else
                % accumulate elapsed only
                this.elapsed = time;
            end
        end
        
        function res = getClosetValue(this, vehicle)
            pos = vehicle.position;
            if pos(1)*pos(2) > 0
                res = this.h_value;
            else
                res = this.v_value;
            end
        end
        
        function res = getValue(this)
            res = this.h_value;
        end
        
        function setValue(this, val)
            switch val
                case 0
                    this.h_value = traffLight.GREEN;
                    this.v_value = traffLight.RED;
                otherwise
                    this.h_value = traffLight.RED;
                    this.v_value = traffLight.GREEN;
            end
        end
        
        % draw the traffic light on the road intersection
        function draw(this)
            % light for horizontal lane
            fill([0.25 -0.25 -0.25 0.25] + this.x, ...
                [0.25 0.25 -0.25 -0.25] + this.y, [0 0 0]);
            traffLight.circle(this.x, this.y, 0.25, this.h_value, this.h_value);
            fill([0.25 -0.25 -0.25 0.25] + -this.x, ...
                [0.25 0.25 -0.25 -0.25] + -this.y, [0 0 0]);
            traffLight.circle(-this.x, -this.y, 0.25, this.h_value, this.h_value);
            
            % light for vertical lane
            fill([0.25 -0.25 -0.25 0.25] + -this.x, ...
                [0.25 0.25 -0.25 -0.25] + this.y, [0 0 0]);
            traffLight.circle(-this.x, this.y, 0.25, this.v_value, this.v_value);
            fill([0.25 -0.25 -0.25 0.25] + this.x, ...
                [0.25 0.25 -0.25 -0.25] + -this.y, [0 0 0]);
            traffLight.circle(this.x, -this.y, 0.25, this.v_value, this.v_value);
        end
    end
    
    methods (Static)     
        % helper function to draw circle
        function h = circle(x, y, r, MarkerFaceColor, MarkerEdgeColor)
            c = [x y];
            pos = [c-r 2*r 2*r];
            h = rectangle('Position', pos, 'Curvature', [1 1], ...
                'FaceColor', MarkerFaceColor, 'Edgecolor', MarkerEdgeColor);
        end
    end
end