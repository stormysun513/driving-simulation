classdef pedestrian < handle
    
    properties
        direction
        progress
        length
        start
    end
    
    methods
        function this = pedestrian(varargin)
            if nargin
                this.start = varargin{1};
            else
                this.start = [-1 -1.125];
            end
            this.length = 2;
            this.progress = 0;
            this.direction = [1 0];
        end
        
        function setProgress(this, progress)
            this.progress = progress;
        end
        
        function draw(this)
            if this.progress ~= -1
                pos = this.start + (this.progress*this.length)*this.direction;
                plot(pos(1),pos(2),'m.','MarkerSize',20);
            end
        end
    end
end