WORLD_SIZE = 8;
LANE_WIDTH = 1;
LANE_LINE = 0.75;

GRAY = [0.8 0.8 0.8];
WHITE = [1 1 1];
BLACK = [0 0 0];
RED = [1 0 0];

light1 = myTrafficLight(-1.25, -1.25, 10);
car1 = vehicle([-7.5 -0.5], [1, 0], [1, 0]);

figure('Name', 'Simulation', 'NumberTitle', 'off');

for t = 0:1:300
    
    % hold on to draw multiple figure on a canvas
    hold on;
    
    % draw road intersection
    h = fill([-WORLD_SIZE -WORLD_SIZE WORLD_SIZE WORLD_SIZE], ...
             [-LANE_WIDTH LANE_WIDTH LANE_WIDTH -LANE_WIDTH], GRAY);
    set(h, 'EdgeColor', 'None');
    h = fill([-LANE_WIDTH LANE_WIDTH LANE_WIDTH -LANE_WIDTH], ...
             [-WORLD_SIZE -WORLD_SIZE WORLD_SIZE WORLD_SIZE], GRAY);
    set(h, 'EdgeColor', 'None');
    
    % draw lane boundaries ([x1 x2], [y1 y2])
    plot([-WORLD_SIZE -LANE_WIDTH -LANE_WIDTH], ...
        [-LANE_WIDTH -LANE_WIDTH -WORLD_SIZE], 'k', 'LineWidth', 2);
    plot([-WORLD_SIZE -LANE_WIDTH -LANE_WIDTH], ...
        [LANE_WIDTH LANE_WIDTH WORLD_SIZE], 'k', 'LineWidth', 2);
    plot([LANE_WIDTH LANE_WIDTH WORLD_SIZE], ...
        [-WORLD_SIZE -LANE_WIDTH -LANE_WIDTH], 'k', 'LineWidth', 2);
    plot([LANE_WIDTH LANE_WIDTH WORLD_SIZE], ...
        [WORLD_SIZE LANE_WIDTH LANE_WIDTH], 'k', 'LineWidth', 2);
    
    % road intersection at x = [-1, 1], and y = [-1, 1]
    plot([-1 -1 1 1 -1], [-1 1 1 -1 -1], 'w', 'LineWidth', 2);
    plot([-1.25 -1.25], [-1 1], 'w', 'LineWidth', 2);
    plot([1.25 1.25], [-1 1], 'w', 'LineWidth', 2);
    plot([-1 1], [-1.25 -1.25], 'w', 'LineWidth', 2);
    plot([-1 1], [1.25 1.25], 'w', 'LineWidth', 2);
    
    % add traffic sign
    light1.update(0.1);
    light1.draw();
    
    % draw white line in the middle of road
    for i = LANE_WIDTH:2:WORLD_SIZE
        plot([i+1 i+2], [0 0], 'w', 'LineWidth', 2);
        plot([0 0], [i+1 i+2], 'w', 'LineWidth', 2);
    end
    for i = -LANE_WIDTH:-2:-WORLD_SIZE
        plot([i-1 i-2], [0 0], 'w', 'LineWidth', 2);
        plot([0 0], [i-1 i-2], 'w', 'LineWidth', 2);
    end

    % a single car
    car1.moveStep(0.05)
    car1.draw();
    
    axis([-WORLD_SIZE WORLD_SIZE -WORLD_SIZE WORLD_SIZE]);
    hold off;
   
    pause(0.03);
end