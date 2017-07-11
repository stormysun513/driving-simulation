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
        vehicle.setDrivingState(dstate(i));
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