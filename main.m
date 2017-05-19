% initialize global variables
env = environ(8, 1);
light1 = myTrafficLight(-1.25, -1.25, 4);
car1 = vehicle([-7.5 -0.5], [1, 0], [1, 0]);

env.addLight(light1);
figure('Name', 'Simulation', 'NumberTitle', 'off');

for t = 0:1:200
    
    % hold on to draw multiple figure on a canvas
    hold on;

    % update states of environment
    env.update(0.1); 
    
    % draw environment       
    env.draw();
    
    % a single car
    car1.moveStep(0.1)
    car1.draw();
    
    hold off;
    pause(0.03);
end