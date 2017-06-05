% M-file to run simulink model

% clear variables on workspace
clear;

% add path
addpath 'environ/';

% params
WORLD_SIZE = 8;
LANE_WIDTH = 1;
LIGHT_POS = [-1.25 -1.25];
NUM = 1;
SAFE_DIST = 1;

% create display objects
env = environment(WORLD_SIZE, LANE_WIDTH); 
light = traffLight(LIGHT_POS);

% add light and vehicles to the map
env.addLight(light);
for i=1:NUM
    env.addVehicle(vehicle());
end

% run simulation
mdl = 'statechart';
load_system(mdl);
createVehicle(mdl, NUM);
cs = getActiveConfigSet(mdl);
set_param(cs, 'StopTime', '15');
sim(mdl);

% create a canvas for visual output
figure('Name', 'Simulation', 'NumberTitle', 'off');

% prepare light status data
light_status = squeeze(light_status);

% replay simulation result
for i=1:length(light_status)
    
    % update light status
    light.setValue(light_status(i));
    
    % update vehicle position
    % Reminder: dim of 'pos' is [1, NUM, POINTS]
    for k=1:NUM
        vehicle = env.getVehicle(k);
        vehicle.setPos(squeeze(pos(k,:,i)));
    end
    
    % redraw the screen
    env.draw();
    pause(0.005);
end

% close simulation window
close 'Simulation';