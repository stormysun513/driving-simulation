%{ 

file: intersection.m
author: yu lun tsai
date: Aug 15, 2017
email: stormysun513@gmail.com

the intersection environment handle is used in the intersection model.
it has several fields to determine how the environment is rendered

world_size      - the length of the rounded highway in the window. once cars
                exceeds the left end of the window, they will appears in the 
                right end

lane_width      - the lane width of highway
light           - a light handle
intersection_x  - specify the horizontal boundary of the intersection
                region
intersection_y  - dpecify the vertical boundary of the intersection region
vehicles        - a cell array storing vehicle handles, when intersection.draw() 
                is called, it will call the draw function in each vehicle
pedestrians     - a cell array storing pedestrian handles, when 
                intersection.draw() is called, it will call the draw
                funciton in each pedestrian
%}

classdef intersection < handle
    
    properties
        world_size
        lane_width
        light
        intersect_x
        intersect_y
        vehicles
        pedestrians
    end
    
    properties (Constant)
        GRAY = [0.8 0.8 0.8];
        WHITE = [1 1 1];
        BLACK = [0 0 0];
        LANE_LINE = 0.75;
    end

    methods
        % constructor
        function this = intersection(varargin)
            fields = {'world_size','lane_width'};
            this.world_size = 8;
            this.lane_width = 1;
            for i = 1:nargin
                this.(fields{i}) = varargin{i};
            end
            
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
        
        % return the number of vehicle on the map
        function num = numOfVehicles(this)
            num = length(this.vehicles);
        end
        
        % return the vehicle instance based on idx
        function v = getVehicle(this, idx)
            v = this.vehicles{idx};
        end
        
        % add light to the map
        function res = addLight(this, l)
            if isa(l, 'traffLight') == 0
                res = false;
                return;
            end
            this.light = l;
        end
        
        % delete the light from the map
        function deleteLight(this)
            this.light = [];
        end
       
        % return the current status of light on the map
        function res = getLightStatus(this)
            res = this.light.getValue();
        end
        
        % add pedestrian to the map
        function res = addPedestrian(this, p)
            if isa(p, 'pedestrian') == 0
                res = false;
                return;
            end
            if sum(this.vehicles == p) ~= 0
                res = false;
                return;
            end
            res = true;
            this.pedestrians{end+1} = p;
        end
        
        % return the pedestrian instance based on idx
        function v = getPedestrian(this, idx)
            v = this.pedestrians{idx};
        end
        
        % get the distance from intersection based on vehicle idx
        function dist = getIntersectDistByID(this, idx)
            dist = this.getIntersectDist(this.vehicles{idx});
        end
        
        % get the distance from intersection based on the vehicle instance
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
        
        % update the screen
        function draw(this)
            clf;
            hold on;
            this.drawRoads();
            if ~isempty(this.light)
                this.light.draw();
            end
            
            for k=1:length(this.vehicles)
                v = this.vehicles{k};
                v.draw();
            end
            
            for k=1:length(this.pedestrians)
                p = this.pedestrians{k};
                p.draw();
            end
            hold off;
        end
        
        % draw roads
        function drawRoads(this)
            
            wsize = this.world_size;    % world size
            lwidth = this.lane_width;   % lane width
            cwwidth = 0.25*lwidth;      % crosswalk width
            lllength = 0.75*lwidth;     % lane line width
            
            axis([-1 1 -1 1]*wsize);
            
            % draw road intersection centered at (0, 0)
            h = fill([-1 -1 1 1]*wsize, [-1 1 1 -1]*lwidth, intersection.GRAY);
            set(h, 'EdgeColor', 'None');
            h = fill([-1 1 1 -1]*lwidth, [-1 -1 1 1]*wsize, intersection.GRAY);
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