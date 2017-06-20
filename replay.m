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
    for k=1:NUM_OF_CARS
        vehicle = env.getVehicle(k);
        vehicle.setPosDir(squeeze(pos(k,:,i)), squeeze(dir(k,:,i)));
    end
    
    % update pedestrians
    pedestrian = env.getPedestrian(1);
    pedestrian.setProgress(ppos(i));
    
    % redraw the screen
    env.draw();
    pause(0.01);
end

% close simulation window
close 'Simulation';