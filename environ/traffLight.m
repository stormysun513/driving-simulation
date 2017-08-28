%{ 

file: trafficLight.m
author: yu lun tsai
date: Aug 15, 2017
email: stormysun513@gmail.com

the light handle class that defines the propeties used to display the
traffic light status at the road intersection

x               - the x position of the left-bottom light
y               - the y position of the left-bottom light
h_value         - the light status for the horizontal traffic
v_value         - the light status for the vertical traffic
elapsed         - the time elapsed since last change
interval        - the period of the traffic light

%}

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
        YELLOW = [1 1 0];
    end
    
    methods
        
        % constructor
        function this = traffLight(varargin)
            
            this.elapsed = 0;
            this.interval = 5;
            this.h_value = traffLight.GREEN;
            this.v_value = traffLight.RED;
            this.x = varargin{1}(1);
            this.y = varargin{1}(2);
            
            if nargin > 1
                this.interval = varargin{2};
            end
            if nargin > 2
                this.elapsed = varargin{3};
            end
        end
        
        % update current pedestrian position
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
        
        % given a vehicle handle, this function return the current
        % light status targeted for it based on its location
        function res = getClosetValue(this, vehicle)
            pos = vehicle.position;
            if pos(1)*pos(2) > 0
                res = this.h_value;
            else
                res = this.v_value;
            end
        end
        
        % get the current status
        function res = getValue(this)
            res = this.h_value;
        end
        
        % update the current status
        function setValue(this, val)
            switch val
                case 1
                    this.h_value = traffLight.RED;
                    this.v_value = traffLight.GREEN;
                case 2
                    this.h_value = traffLight.RED;
                    this.v_value = traffLight.YELLOW;
                case 3
                    this.h_value = traffLight.GREEN;
                    this.v_value = traffLight.RED;
                case 4
                    this.h_value = traffLight.YELLOW;
                    this.v_value = traffLight.RED;
                otherwise
                    % no changes for other intermediate value
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
    
    % helper function for drawing circle in matlab gui window
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