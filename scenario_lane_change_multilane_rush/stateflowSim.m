% M-file to run stateflow simulation

% clear variables on matlab workspace
clear;

% add path for gui objects
addpath '../environ/';

WORLD_SIZE = 12;
LANE_WIDTH = 1;
LANE_NUM = 4;

% simulation configuration
START_TIME = 0;
STOP_TIME = 60; 

% vehicles configuration
NUM_OF_CARS = 6;

% prepare parameters
params = containers.Map('UniformValues',false);
params('WORLD_SIZE') = WORLD_SIZE;
params('LANE_WIDTH') = LANE_WIDTH;
params('LANE_NUM') = LANE_NUM;
params('NUM_OF_CARS') = NUM_OF_CARS;

% create the environment
env = highway();

% add
vehicle.getOrSetNextIndex(0);
for i=1:NUM_OF_CARS
    v = vehicle();
    v.setWarnRegionEnabled(false);
    env.addVehicle(v);
end

% run simulation
mdl = 'laneChange1';
load_system(mdl);
% randomInitialize(mdl,params);
% configModel(mdl,params);
cs = getActiveConfigSet(mdl);
set_param(cs, 'StartTime', int2str(START_TIME));
set_param(cs, 'StopTime', int2str(STOP_TIME));
sim(mdl);

% create a canvas for visual output
figure('Name', 'Simulation', 'NumberTitle', 'off');

% play the simulation result
for i=1:size(pos,3)
    
    % update vehicle position
    % Reminder: dim of 'pos' is [2, NUM, POINTS]
    for k=1:NUM_OF_CARS
        vehicle = env.getVehicle(k);
        vehicle.setPos(squeeze(pos(:,k,i))');
    end
    
    % redraw the screen
    env.draw();
    pause(0.03);
end

% close simulation window
close 'Simulation';