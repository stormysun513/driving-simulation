% M-file to run stateflow simulation

% clear all variables on matlab workspace
clear;

% add path for gui objects
addpath '../environ/';

% parameters
% WORLD_SIZE determines the length of road
WORLD_SIZE = 5;

% vehicles configuration
% NUM_OF_CARS determines the number of cars, the one that is labeled number
% 1 is the autonomous car, others remain static during the simulation
NUM_OF_CARS = 6; 

% simulation configuration
START_TIME = 0;
STOP_TIME = 40; 

% create the environment
env = road();

% create vehivles
vehicle.getOrSetNextIndex(0);
for i=1:NUM_OF_CARS
    v = vehicle();
    v.setWarnRegionEnabled(false);
    env.addVehicle(v);
end

% run simulation
mdl = 'parallelParking';
load_system(mdl);
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
        vehicle.setPosDir(squeeze(pos(:,k,i))', squeeze(dir(:,k,i))');
    end
    
    % draw the screen
    env.draw();
    pause(0.03);
end

% close simulation window
close 'Simulation';