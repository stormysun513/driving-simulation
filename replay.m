% create a canvas for visual output
figure('Name', 'Simulation', 'NumberTitle', 'off');

% prepare light status data
lightStatus = squeeze(lightStatus);

% replay simulation result
for i=1:length(lightStatus)
    
    % update light status
    light.setValue(lightStatus(i));
    
    % update vehicle position
    % Reminder: dim of 'pos' is [1, NUM, POINTS]
    for k=1:NUM_OF_CARS
        vehicle = env.getVehicle(k);
        vehicle.setPosDir(squeeze(pos(:,k,i))', squeeze(dir(:,k,i))');
    end
    
    % update pedestrians
    pedestrian = env.getPedestrian(1);
    pedestrian.setProgress(ppos(i,1));
    
    % redraw the screen
    env.draw();
    pause(0.01);
end

% close simulation window
close 'Simulation';