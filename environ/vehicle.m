classdef vehicle < handle
    
    properties
        position
        orientation
        velocity
        agent
    end
    
    methods
        
        % constructor
        function this = vehicle(varargin)
            this.position = varargin{1};
            
            if nargin > 1
                if ~any(varargin{2})
                    this.orientation = [1 0];
                else
                    this.orientation = varargin{2}/norm(varargin{2});
                end
            else
                this.orientation = [1 0];
            end
            
            if nargin > 2
                this.velocity = varargin{3};
            else
                this.velocity = [0 0];
            end
            
            if nargin > 3
                this.agent = varargin{4};
            else
                this.agent = [];
            end
        end
        
        % update next state based on environment and itself
        function update(this, env)
            if isempty(this.agent) == false
                this.agent.update(env, this);
            else
                error('No driving agent is assigned.');
            end
        end
        
        % set internal attribute directly
        function setPos(this, position)
            this.position = position;
        end
        
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
            fill(tmp(:,1)', tmp(:,2)', [0 0.8 0]);
        end
    end
end