%{ 

file: pedestrian.m
author: yu lun tsai
date: Aug 15, 2017
email: stormysun513@gmail.com

the pedestrian class define the properties required to display a pedestrian
on the window

direction
progress
length
start

%}

classdef pedestrian < handle
    
    properties
        direction
        progress
        length
        start
    end
    
    methods
        
        % constructor
        function this = pedestrian(varargin)
            
            fields = {'start','direction'};
            
            this.start = [-1 -1.125];
            this.direction = [1 0];
            this.length = 2;
            this.progress = -1;
            
            % assign values if provided
            for i = 1:min(nargin, length(fields))
                this.(fields{i}) = varargin{i};
            end
        end
        
        % update pedestrian progress
        function setProgress(this, progress)
            this.progress = progress;
        end
        
        % draw the pedestrian position based on its pregress, initial
        % position and proceeding direction
        function draw(this)
            if this.progress ~= -1
                pos = this.start + (this.progress*this.length)*this.direction;
                plot(pos(1),pos(2),'m.','MarkerSize',20);
            end
        end
    end
end