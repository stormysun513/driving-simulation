classdef vehicle < handle
    
    properties
        id
        position
        orientation
        velocity
        agent
        color
    end
    
    methods (Static)
        function out = getNextIndex()
            persistent count;
            if isempty(count), count = 0; end
            count = count + 1;
            out = count;
        end
    end
    
    methods
        
        % constructor
        function this = vehicle(varargin)
            this.id = vehicle.getNextIndex();
            this.position = [0 0];
            this.orientation = [1 0];
            this.velocity = [0 0];
            this.color = rand(1, 3);
            
            if nargin, this.position = varargin{1}; end
            if nargin > 1
                if ~any(varargin{2})
                    warning('zero vector is not allowed for direction');
                else
                    this.orientation = varargin{2}/norm(varargin{2});
                end
            end
            if nargin > 2, this.velocity = varargin{3}; end
            if nargin > 3, this.agent = varargin{4}; end
        end
        
        % update next state based on environment and itself
        function update(this, env)
            if isempty(this.agent) == false
                this.agent.update(env, this);
            else
                error('No driving agent is assigned.');
            end
        end
        
        % get vehicle id
        function id = getID(this)
            id = this.id;
        end
        
        % set internal attribute directly
        function setPos(this, position)
            this.position = position;
        end
        
        % get current position
        function pos = getPos(this)
            pos = this.position;
        end
        
        % draw function for vehicles
        function draw(this)
            
            r1 = [4/5 -3/5; 3/5 4/5];
            r2 = [4/5 3/5; -3/5 4/5];
            a1 = this.position+(0.25*r1*this.orientation')';
            a2 = this.position+(0.25*r2*this.orientation')';
            a11 = a1 - 0.4*this.orientation;
            a22 = a2 - 0.4*this.orientation;
            
            tmp = [a1; a2; a22; a11; a1];
            plot(tmp(:,1)', tmp(:,2)', 'b', 'LineWidth', 2);
            fill(tmp(:,1)', tmp(:,2)', this.color);
        end
    end
end