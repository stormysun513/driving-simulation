%{

the vehicle handle object, fields in the properties block should be self
explanatory

id          - the car id used to distinguish different cars
position    - car position (corresponding to data store X in simulink model)
orientation - car orientation (corresponding to data store D in simulink model)
velocity    - not used in the simulink model (obsolete)
agent       - not used in the simulink model (obsolete)
color       - car color, determined at the constructor
label       - text form of the id

<< gui properties for warning region display >>

showWarnRegion
frontAngle
longSafeDist
shortSafeDist

%}

classdef vehicle < handle
    
    properties
        id
        position
        orientation
        velocity
        drivingState
        agent
        color
        label
        showWarnRegion
        frontAngle
        longSafeDist
        shortSafeDist
    end
    
    methods (Static)
        function out = getOrSetNextIndex(varargin)
            persistent count;
            if isempty(count), count = 0; end
            if nargin
                if isnumeric(varargin{1})
                    count = varargin{1};
                end
            else
                count = count + 1;
                out = count;
            end
        end
    end
    
    methods
        
        % constructor: it accepts four arguments during instantiation
        % 1. position
        % 2. orientation
        % 3. velocity
        % 4. agent type
        function this = vehicle(varargin)
            this.id = vehicle.getOrSetNextIndex();
            this.position = [0 0];
            this.orientation = [1 0];
            this.velocity = [0 0];
            this.drivingState = DrivingState.Straight;
            this.color = rand(1, 3);
            this.label = int2str(this.id);
            
            this.showWarnRegion = true;
            
            % set default warning angle to deg2rad(45)
            this.frontAngle = 0.7854;
            this.longSafeDist = 1;
            this.shortSafeDist = 0.5;
            
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
        
        % set the current driving state
        function setDrivingState(this, state)
            this.drivingState = state;
        end
        
        % get vehicle id
        function id = getID(this)
            id = this.id;
        end
        
        % enable or diable warning region display
        function setWarnRegionEnabled(this, enabled)
            this.showWarnRegion = enabled;
        end
        
        % change the fan-shaped region according to states in the simlulink
        % model
        function setLongSafeDist(this, dist)
            this.longSafeDist = dist;
        end
        
        % change the fan-shaped angle according to states in the simlulink
        % model
        function setFrontAngle(this, angle)
            this.frontAngle = deg2rad(angle);
        end
        
        % set position directly
        function setPos(this, position)
            this.position = position;
        end
        
        % set position and orientation directly
        function setPosDir(this, position, direction)
            this.position = position;
            this.orientation = direction;
        end
        
        % get current position
        function pos = getPos(this)
            pos = this.position;
        end
        
        % draw function for vehicles
        function draw(this)
            this.drawVehicle();
            if this.showWarnRegion
                this.drawWarnArea();
            end
        end
        
        % update the vehicle on the gui
        function drawVehicle(this)
            
            r1 = [4/5 -3/5; 3/5 4/5];
            r2 = [4/5 3/5; -3/5 4/5];
            a1 = this.position+(0.25*r1*this.orientation')';
            a2 = this.position+(0.25*r2*this.orientation')';
            a11 = a1 - 0.4*this.orientation;
            a22 = a2 - 0.4*this.orientation;
            
            tmp = [a1; a2; a22; a11; a1];
            plot(tmp(:,1)', tmp(:,2)', 'b', 'LineWidth', 2);
            fill(tmp(:,1)', tmp(:,2)', this.color);
            
            label_pos = this.position + [-0.1 0.5];
            text(label_pos(1),label_pos(2),this.label);
            
        end
        
        % draw the warning region (use showWarnRegion as a flag to determine
        % whether to show the region)
        function drawWarnArea(this)
            
            theta = this.frontAngle;
            half = 1.5708;
            
            d = this.orientation;
            x0 = this.position(1);
            y0 = this.position(2);
            
            offset = 0;
            r1 = 1*this.longSafeDist;
            r2 = this.shortSafeDist;
            
            if this.drivingState == DrivingState.RightTurn
                offset = 0.5236;
            elseif this.drivingState == DrivingState.LeftTurn
                offset = -0.5236;
                r1 = 1.5*r1; 
            end
            
            rot1 = [cos(theta+offset) sin(theta+offset);...
                -sin(theta+offset) cos(theta+offset)];
            rot2 = [cos(half) sin(half); -sin(half) cos(half)];
            
            d1 = (rot1*d');
            d2 = (rot2*d');
       
            a1 = atan2(d1(2), d1(1));
            a2 = a1 + theta*2;
            t = linspace(a1,a2);
            x = x0 + r1*cos(t);
            y = y0 + r1*sin(t);
            plot([x0,x,x0],[y0,y,y0],'b-')
            
            a1 = atan2(d2(2), d2(1));
            a2 = a1 + half*2;
            t = linspace(a1,a2);
            x = x0 + r2*cos(t);
            y = y0 + r2*sin(t);
            plot([x0,x,x0],[y0,y,y0],'b-')
        end
    end
end