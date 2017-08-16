function randomInitialize(mdl, args)

% mdl = 'lineChanging';
% args = containers.Map('UniformValues',false);

% initialize positions
wsize = 12;
lwidth = 1;
lnum = 4;

if isKey(args, 'WORLD_SIZE')
    wsize = args('WORLD_SIZE');
end
if isKey(args, 'LANE_WIDTH')
    lwidth = args('LANE_WIDTH');
end
if isKey(args, 'LANE_NUM')
    lnum = args('LANE_NUM');
end

rwidth = lwidth*lnum;
if mod(lnum,2) == 0
    pos_y = -1*(rwidth/2-0.5):1:(rwidth/2-0.5);
else
    pos_y = -1*(rwidth/2):1:(rwidth/2);
end
pos_x = -wsize:1:(wsize-1);
pos = combvec(pos_x, pos_y);

% get current initial positions
X = getSimulinkBlockHandle(strcat(mdl,'/Position'));
x = str2num(get_param(X,'InitialValue'));

x1 = pos(:,randsample(2:size(pos,2),1));
while sum(ismember(x(:,1:end)', x1', 'rows'))
    x1 = pos(:,randsample(2:size(pos,2),1));
end

x(:,1) = x1;
set_param(X,'InitialValue',mat2str(x));