%{ 

file: highway.m
author: yu lun tsai
date: Aug 15, 2017
email: stormysun513@gmail.com

the highway environment is used in the multilane_rush and twolane_rush
model. it has several fields to determine how the environment is rendered

world_size      - the length of the rounded highway in the window. once cars
                exceeds the left end of the window, they will appears in the 
                right end

lane_width      - the lane width of highway
lane_num        - the number of lanes in the highway
vehicles        - a cell array used to store vehicle handles, when
                highway.draw() is called, it will call the draw function in
                each vehicle

%}

classdef highway < handle
    
    properties
        world_size
        lane_width
        lane_num
        vehicles
    end
    
    properties (Constant)
        GRAY = [0.8 0.8 0.8];
        WHITE = [1 1 1];
        BLACK = [0 0 0];
        LANE_LINE = 0.75;
    end
    
    methods
        % constructor: the order of argument is specified in fields
        function this = highway(varargin)
            fields = {'world_size','lane_width','lane_num'};
            this.world_size = 12;
            this.lane_width = 1;
            this.lane_num = 4;
            for i = 1:nargin
                this.(fields{i}) = varargin{i};
            end
            this.vehicles = {};
        end
        
        % add a vehicle to the environment
        function res = addVehicle(this, v)
            res = false;
            if isa(v, 'vehicle') && sum(this.vehicles == v) == 0
                this.vehicles{end+1} = v;
                res = true;
            end
        end
        
        % delete a vehicle from environ
        function delVehicle(this, v)
            if isa(v, 'vehicle')
                idx = find(this.vehicles == v);
                if ~isempty(idx)
                    this.vehicles{idx} = [];
                end
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
            clf;
            hold on;
            this.drawRoads();
            
            for k=1:length(this.vehicles)
                v = this.vehicles{k};
                v.draw();
            end
            hold off;
        end
        
        % draw roads
        function drawRoads(this)
            
            wsize = this.world_size;                    % world size
            lnum = this.lane_num;                       % lane num
            lwidth = this.lane_width;                   % lane width
            
            % compute the width of half road
            rwidth = lwidth*lnum;
            hrwidth = rwidth/2;
            
            % set the range of figure
            axis([-wsize wsize -hrwidth hrwidth]);
            axis equal;
            
            % draw a multi-lane road
            h = fill([-1 -1 1 1]*wsize, [-1 1 1 -1]*hrwidth, ...
                highway.GRAY);
            set(h, 'EdgeColor', 'None');
            
            % draw lane boundaries ([x1 x2], [y1 y2])
            plot([-1 1]*wsize, [-1 -1]*hrwidth, 'k', 'LineWidth', 2);
            plot([-1 1]*wsize, [1 1]*hrwidth, 'k', 'LineWidth', 2);
            
            % draw white line in the middle of road
            for i = (-hrwidth+lwidth):lwidth:(hrwidth-lwidth)
                for j = -wsize:2:wsize
                    plot([j+1 j+2], [1 1]*i, 'w', 'LineWidth', 2);
                end
            end
        end   
    end
end