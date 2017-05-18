WORLD_SIZE = 8;
LANE_WIDTH = 1;
LANE_LINE = 0.75;

GRAY = [0.8 0.8 0.8];
WHITE = [1 1 1];
BLACK = [0 0 0];

env = environ(8, 1);
light1 = myTrafficLight(-1.25, -1.25, 10);
car1 = vehicle([-7.5 -0.5], [1, 0], [1, 0]);

figure('Name', 'Simulation', 'NumberTitle', 'off');

for t = 0:1:300
    
    % hold on to draw multiple figure on a canvas
    hold on;

    % draw environment
    env.draw();

    % add traffic sign
    light1.update(0.1);
    light1.draw();
    
    % a single car
    car1.moveStep(0.05)
    car1.draw();
    
    hold off;
    pause(0.03);
end