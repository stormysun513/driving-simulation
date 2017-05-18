classdef myTrafficLight < handle
    
    properties
        x
        y
        value
        elapsed
        interval
    end
    
    properties (Constant)
        RED = [1 0 0];
        GREEN = [0 1 0];
    end
    
    methods
        
        function this = myTrafficLight(varargin)
            this.x = varargin{1};
            this.y = varargin{2};
            this.interval = varargin{3};
            if nargin > 3
                this.value = varargin{4};
            else
                this.value = myTrafficLight.GREEN;
            end
            this.elapsed = 0;
        end
        
        function update(this, delta)
            time = this.elapsed + delta;
            if time >= this.interval
                % switch state
                if this.value == myTrafficLight.GREEN
                    this.value = myTrafficLight.RED;
                else
                    this.value = myTrafficLight.GREEN;
                end
                this.elapsed = mod(time, this.interval);
            else
                % accumulate elapsed only
                this.elapsed = time;
            end
        end
        
        function res = getValue(this)
            res = this.value;
        end
        
        function draw(this)
            fill([0.25 -0.25 -0.25 -0.25] + this.x, ...
                [0.25 0.25 -0.25 -0.25] + this.y, [0 0 0]);
            circle(this.x, this.y, 0.25, this.value, this.value);
        end
    end
end