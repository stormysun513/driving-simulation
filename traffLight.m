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
            this.interval = varargin{2};
            this.elapsed = varargin{3};
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
        
        function pos = getPos(this)
            pos = [this.x this.y];
        end
        
        function res = getValue(this)
            res = this.h_value;
        end
        
        function draw(this)
            % horizontal
            fill([0.25 -0.25 -0.25 0.25] + this.x, ...
                [0.25 0.25 -0.25 -0.25] + this.y, [0 0 0]);
            circle(this.x, this.y, 0.25, this.h_value, this.h_value);
            fill([0.25 -0.25 -0.25 0.25] + -this.x, ...
                [0.25 0.25 -0.25 -0.25] + -this.y, [0 0 0]);
            circle(-this.x, -this.y, 0.25, this.h_value, this.h_value);
            
            % verical
            fill([0.25 -0.25 -0.25 0.25] + -this.x, ...
                [0.25 0.25 -0.25 -0.25] + this.y, [0 0 0]);
            circle(-this.x, this.y, 0.25, this.v_value, this.v_value);
            fill([0.25 -0.25 -0.25 0.25] + this.x, ...
                [0.25 0.25 -0.25 -0.25] + -this.y, [0 0 0]);
            circle(this.x, -this.y, 0.25, this.v_value, this.v_value);
        end
    end
end