% add path
addpath 'environ/';
addpath 'states/';
addpath 'agents/';

% parameters
interval = 0.1;

% initialize global variables
env = environment(8, 1);                            % world_size, lane_width
light = traffLight([-1.25 -1.25], 5, 1);            % pos_x, pos_y, period, offset
agent = simpleAgent(1, 0.1, 0.4);                   % max_speed, delta, max_acc
car1 = vehicle([-7.5 -0.5], [1, 0], [1, 0], agent); % pos, dir, v

% configure the environment
env.addLight(light);

% create a canvas for visual output
figure('Name', 'Simulation', 'NumberTitle', 'off');

for t = 0:1:200
    
    % hold on to draw multiple figure on a canvas
    hold on;

    % update states of environment and draw
    env.update(0.1);      
    env.draw();
    
    % a single car
    car1.update(env);
    car1.draw();
    
    hold off;
    pause(0.03);
end

close 'Simulation';