% M-file to run simulink model

% clear variables on workspace
clear;

% add path
addpath 'environ/';

% run simulation
mdl = 'statechart';
cs = getActiveConfigSet(mdl);
set_param(cs, 'StopTime', '10');
sim(mdl);

% create display objects
env = environment(8, 1);                       % world_size, lane_width
light = traffLight([-1.25 -1.25], 5, 1);       % pos_x, pos_y, period, offset
car = vehicle([-7.5 -0.5], [1, 0], [1, 0]);    % pos, dir, v

% configure the environment
env.addLight(light);
env.addVehicle(car);

% create a canvas for visual output
figure('Name', 'Simulation', 'NumberTitle', 'off');

% replay simulation result
for i=1:length(time)
    hold on;
    
    light.setValue(light_status(i));
    car.setPos([pos_1(i) -0.5]);
    
    env.draw();
    
    pause(0.005);
    hold off;
end

% close simulation window
close 'Simulation';