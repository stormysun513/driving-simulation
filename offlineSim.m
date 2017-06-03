% M-file to run simulink model

% clear variables on workspace
clear;

% add path
addpath 'environ/';

% params
WORLD_SIZE = 8;
LANE_WIDTH = 1;
LIGHT_POS = [-1.25 -1.25];

% create display objects
env = environment(WORLD_SIZE, LANE_WIDTH); 
light = traffLight(LIGHT_POS);
car1 = vehicle();
car2 = vehicle();

% configure the environment
env.addLight(light);
env.addVehicle(car1);
env.addVehicle(car2);

% run simulation
mdl = 'statechart2';
cs = getActiveConfigSet(mdl);
set_param(cs, 'StopTime', '10');
sim(mdl);

% create a canvas for visual output
figure('Name', 'Simulation', 'NumberTitle', 'off');

pos_1 = squeeze(pos_1);
pos_2 = squeeze(pos_2);
light_status = squeeze(light_status);

% replay simulation result
for i=1:length(light_status)
    
    light.setValue(light_status(i));
    car1.setPos(pos_1(:, i)');
    car2.setPos(pos_2(:, i)');
    
    env.draw();
    pause(0.005);
end

% close simulation window
close 'Simulation';