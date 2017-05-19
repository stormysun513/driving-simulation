classdef traffLight < handle
    
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
        
        function this = traffLight(varargin)
            this.x = varargin{1}(1);
            this.y = varargin{1}(2);
            this.interval = varargin{2};
            this.elapsed = varargin{3};
            if nargin > 3
                this.value = varargin{4};
            else
                this.value = traffLight.GREEN;
            end
        end
        
        function update(this, delta)
            time = this.elapsed + delta;
            if time >= this.interval
                % switch state
                if this.value == traffLight.GREEN
                    this.value = traffLight.RED;
                else
                    this.value = traffLight.GREEN;
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
            fill([0.25 -0.25 -0.25 0.25] + this.x, ...
                [0.25 0.25 -0.25 -0.25] + this.y, [0 0 0]);
            circle(this.x, this.y, 0.25, this.value, this.value);
        end
    end
end