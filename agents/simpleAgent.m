classdef simpleAgent < handle
    
    properties
        stack
        interval
        max_speed
        max_acc
    end
    
    methods
        
        function this = simpleAgent(varargin)
            this.stack = {stopState()};
            this.max_speed = varargin{1};
            this.interval = varargin{2};
            this.max_acc = varargin{3};
        end
        
        function update(this, env, vehicle)
            state = this.getCurrentState();
            state.update(this, env, vehicle);
        end
        
        function pushState(this, state)
            this.stack{end+1} = state;
        end
        
        function popState(this)
            this.stack{end} = [];
        end
        
        function state = getCurrentState(this)
            state = this.stack{end};
        end
    end
end