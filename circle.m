function h = circle(x,y,r,MarkerFaceColor,MarkerEdgeColor)
c = [x y];
pos = [c-r 2*r 2*r];
h = rectangle('Position', pos, 'Curvature', [1 1], ...
    'FaceColor', MarkerFaceColor, 'Edgecolor', MarkerEdgeColor);
end