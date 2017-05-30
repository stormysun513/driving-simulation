classdef environment < handle
    
    properties
        world_size
        lane_width
        light
        intersect_x
        intersect_y
        vehicles
    end
    
    properties (Constant)
        GRAY = [0.8 0.8 0.8];
        WHITE = [1 1 1];
        BLACK = [0 0 0];
        LANE_LINE = 0.75;
    end

    methods
        
        % constructor
        function this = environment(varargin)
            this.world_size = varargin{1};
            this.lane_width = varargin{2};
            this.vehicles = {};
            this.light = [];
            this.intersect_x = [-1 1] * this.lane_width;
            this.intersect_y = [-1 1] * this.lane_width;
        end
        
        % update status of all objects in the environ
        function update(this, delta)
            this.light.update(delta);
        end
        
        % add a vehicle to environ
        function res = addVehicle(this, v)
            if isa(v, 'vehicle') == 0
                res = false;
                return;
            end
            if sum(this.vehicles == v) ~= 0
                res = false;
                return;
            end
            res = true;
            this.vehicles{end+1} = v;
        end
        
        % delete a vehicle from environ
        function delVehicle(this, v)
            if isa(v, 'vehicle') == 0
                return;
            end
            idx = find(this.vehicles == v);
            if isempty(idx)
                return;
            end
            this.vehicles{idx} = [];
        end
        
        function res = addLight(this, l)
            if isa(l, 'traffLight') == 0
                res = false;
                return;
            end
            this.light = l;
        end
        
        function deleteLight(this)
            this.light = [];
        end
       
        function res = getLightStatus(this)
            res = this.light.getValue();
        end
        
        function dist = getIntersectDist(this, v)
            pos = v.position;
            if pos(1) < 0 && pos(2) < 0
                dist = this.intersect_x(1) - pos(1);
            elseif pos(1) > 0 && pos(2) > 0
                dist = this.intersect_x(2) - pos(1);
            elseif pos(1) > 0 && pos(2) < 0
                dist = this.intersect_y(1) - pos(2);
            else
                dist = this.intersect_y(2) - pos(2);
            end
        end
        
        function draw(this)
            this.drawRoads();
            this.light.draw();
            for k=1:length(this.vehicles)
                v = this.vehicles{k};
                v.draw();
            end
        end
        
        function drawRoads(this)
            
            wsize = this.world_size;    % world size
            lwidth = this.lane_width;   % lane width
            cwwidth = 0.25*lwidth;      % crosswalk width
            lllength = 0.75*lwidth;     % lane line width
            
            axis([-1 1 -1 1]*wsize);
            
            % draw road intersection centered at (0, 0)
            h = fill([-1 -1 1 1]*wsize, [-1 1 1 -1]*lwidth, environment.GRAY);
            set(h, 'EdgeColor', 'None');
            h = fill([-1 1 1 -1]*lwidth, [-1 -1 1 1]*wsize, environment.GRAY);
            set(h, 'EdgeColor', 'None');
            
            % draw lane boundaries ([x1 x2], [y1 y2])
            plot([-wsize -lwidth -lwidth], ...
                [-lwidth -lwidth -wsize], 'k', 'LineWidth', 2);
            plot([-wsize -lwidth -lwidth], ...
                [lwidth lwidth wsize], 'k', 'LineWidth', 2);
            plot([lwidth lwidth wsize], ...
                [-wsize -lwidth -lwidth], 'k', 'LineWidth', 2);
            plot([lwidth lwidth wsize], ...
                [wsize lwidth lwidth], 'k', 'LineWidth', 2);

            % road intersection at x = [-1, 1], and y = [-1, 1]
            plot([-1 -1 1 1 -1]*lwidth, [-1 1 1 -1 -1]*lwidth, ...
                'w', 'LineWidth', 2);
            
            plot([-1 -1]*(lwidth+cwwidth), [-1 1]*lwidth, 'w', 'LineWidth', 2);
            plot([1 1]*(lwidth+cwwidth), [-1 1]*lwidth, 'w', 'LineWidth', 2);
            plot([-1 1]*lwidth, [-1 -1]*(lwidth+cwwidth), 'w', 'LineWidth', 2);
            plot([-1 1]*lwidth, [1 1]*(lwidth+cwwidth), 'w', 'LineWidth', 2);
            
            % draw white line in the middle of road
            for i = lllength:2:wsize
                plot([i+1 i+2], [0 0], 'w', 'LineWidth', 2);
                plot([0 0], [i+1 i+2], 'w', 'LineWidth', 2);
            end
            for i = -lllength:-2:-wsize
                plot([i-1 i-2], [0 0], 'w', 'LineWidth', 2);
                plot([0 0], [i-1 i-2], 'w', 'LineWidth', 2);
            end
        end  
    end
end