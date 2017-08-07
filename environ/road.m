classdef road < handle
    
    properties
        world_size
        vehicles
    end
    
    properties (Constant)
        GRAY = [0.8 0.8 0.8];
        WHITE = [1 1 1];
        BLACK = [0 0 0];
        LANE_LINE = 0.75;
        LANE_WIDTH = 0.5;
    end
    
    methods
        % constructor
        function this = road(varargin)
            
            % default values
            fields = {'world_size'};
            this.world_size = 5;
            this.vehicles = {};
            
            % assign values if provided
            for i = 1:min(nargin, length(fields))
                this.(fields{i}) = varargin{i};
            end
        end
        
        % add a vehicle to the environment
        function res = addVehicle(this, v)
            res = false;
            if isa(v, 'vehicle') && sum(this.vehicles == v) == 0
                this.vehicles{end+1} = v;
                res = true;
            end
        end
        
        % return the number of vehicle on the map
        function num = numOfVehicles(this)
            num = length(this.vehicles);
        end
        
        % return the vehicle instance based on idx
        function v = getVehicle(this, idx)
            v = this.vehicles{idx};
        end
        
        % update the screen
        function draw(this)
            
            % clear the drawing canvas first
            clf;
            hold on;
            
            % draw the road first
            this.drawRoads();
            
            % draw vehicles
            for k=1:length(this.vehicles)
                v = this.vehicles{k};
                v.draw();
            end
            
            % hold off the current draw operation
            hold off;
        end
        
        % draw roads
        function drawRoads(this)
             
            wsize = this.world_size;                    % world size
            lnum = 2;                                   % lane num
            lwidth = road.LANE_WIDTH;
            
            % compute the width of half road
            rwidth = lwidth*lnum;
            hrwidth = rwidth/2;
            
            % set the range of figure
            axis([-wsize wsize -hrwidth hrwidth]);
            axis equal;
            
            % draw a multi-lane road
            h = fill([-1 -1 1 1]*wsize, [-1 1 1 -1]*hrwidth, ...
                road.GRAY);
            set(h, 'EdgeColor', 'None');
            
            % draw lane boundaries ([x1 x2], [y1 y2])
            plot([-1 1]*wsize, [-1 -1]*hrwidth, 'k', 'LineWidth', 2);
            plot([-1 1]*wsize, [0 0], 'w', 'LineWidth', 1);
            plot([-1 1]*wsize, [1 1]*hrwidth, 'k', 'LineWidth', 2);
            
            % draw the parking spot
            for i = (-wsize+0.5):1:(wsize-0.5)
                plot([1 1]*i, [0 -1]*hrwidth, 'w', 'LineWidth', 1);
            end
        
        end 
    end
end