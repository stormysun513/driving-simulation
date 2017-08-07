% create a canvas for visual output
figure('Name', 'Simulation', 'NumberTitle', 'off');
    
% play the simulation result
for i=1:size(pos,3)
    
    % update vehicle position
    % Reminder: dim of 'pos' is [2, NUM, POINTS]
    for k=1:NUM_OF_CARS
        vehicle = env.getVehicle(k);
        vehicle.setPosDir(squeeze(pos(:,k,i))', squeeze(dir(:,k,i))');
        vehicle.setPos(squeeze(pos(:,k,i))');
    end
    
    % draw the screen
    env.draw();
    pause(0.03);
end

% close simulation window
close 'Simulation';