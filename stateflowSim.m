% M-file to run stateflow simulation

% clear variables on matlab workspace
clear;

% add path for gui objects
addpath 'environ/';
 
% map parameters
WORLD_SIZE = 8;
LANE_WIDTH = 1;
LIGHT_POSITION = [-1.25 -1.25];

% vehicles configuration
NUM_OF_CARS = 3;

% pedestrian configuration
NUM_OF_PEDES = 3;

% traffic rules;
MIN_SAFE_DIST = 1;

% simulation configuration
START_TIME = 0;
STOP_TIME = 40;

% pack parameters into a dictionary
params = containers.Map('UniformValues',false);
params('WORLD_SIZE') = WORLD_SIZE;
params('LANE_WIDTH') = LANE_WIDTH;
params('LIGHT_POSITION') = LIGHT_POSITION;
params('NUM_OF_CARS') = NUM_OF_CARS;
params('SAFE_DIST') = MIN_SAFE_DIST;

% create display objects
env = environment(WORLD_SIZE, LANE_WIDTH); 
light = traffLight(LIGHT_POSITION);

% add light and vehicles to the map
vehicle.getOrSetNextIndex(0);
env.addLight(light);
for i=1:NUM_OF_CARS
    v = vehicle();
    v.setFrontAngle(30);
    env.addVehicle(v);
end

env.addPedestrian(pedestrian([-1 -1.125], [1 0]));
env.addPedestrian(pedestrian([1.125 -1], [0 1]));
env.addPedestrian(pedestrian([1 1.125], [-1 0]));

% run simulation
mdl = 'experiment';
load_system(mdl);
% configModel(mdl,params);
cs = getActiveConfigSet(mdl);
set_param(cs, 'StartTime', int2str(START_TIME));
set_param(cs, 'StopTime', int2str(STOP_TIME));
sim(mdl);

% create a canvas for visual output
figure('Name', 'Simulation', 'NumberTitle', 'off');

% prepare light status data
lightStatus = squeeze(lightStatus);

% prepare driving state data
dstate = squeeze(dstate);

% replay simulation result
for i=1:length(lightStatus)
    
    % update light status
    light.setValue(lightStatus(i));
    
    % update vehicle position
    % Reminder: dim of 'pos' is [1, NUM, POINTS]
    for k=1:NUM_OF_CARS
        vehicle = env.getVehicle(k);
        vehicle.setPosDir(squeeze(pos(:,k,i))', squeeze(dir(:,k,i))');
        vehicle.setDrivingState(dstate(i, k));
    end
    
    % update pedestrians
    for j=1:NUM_OF_PEDES
        pedestrian = env.getPedestrian(j);
        pedestrian.setProgress(ppos(i,j));
    end
    
    % redraw the screen
    env.draw();
    pause(0.01);
end

% close simulation window
close 'Simulation';