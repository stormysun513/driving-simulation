function configModel(mdl, args)

% check whether the 'NUM_OF_CARS' string exists as a key
if ~isKey(args, 'NUM_OF_CARS')
    return;
end

% handle trivial cases
num = args('NUM_OF_CARS');
if num <= 1
    return;
end

% get block diagram object
rt = sfroot;
m = rt.find('-isa','Simulink.BlockDiagram','-and','Name',mdl);

% remove existing vehicles
charts = m.find('-isa','Stateflow.Chart');
v1 = m.find('-isa','Stateflow.Chart','-and','Name','vehicle1');
v2 = m.find('-isa','Stateflow.Chart','-and','Name','vehicle2');

% gather paths of old charts
stack = cell(length(charts),1);
count = 0;
for i=1:length(charts)
    ch = charts(i);
    if startsWith(ch.Name,'vehicle') && ...
            ~strcmp(ch.Name,v1.Name) && ...
            ~strcmp(ch.Name,v2.Name)
        count = count + 1;
        stack{count} = ch.Path;
    end
end

% delete old charts
for i=1:count
    path = stack{i};
    delete_block(path);
end

% create new vehicles
position = get_param(v2.Path,'Position');
base = v2.Path(1:length(v2.Path)-1);
for i=3:num
    idx = int2str(i);
    path = strcat(base,idx);
    position(2) = position(2) + 90;
    position(4) = position(4) + 90;
    add_block(v2.Path,path,'Position',position);
   
    v = m.find('-isa','Stateflow.Chart','-and','Path',path);
    this = v.find('-isa','Stateflow.Data','-and','Name','this');
    set(this.Props,'InitialValue',strcat('uint8(',idx,')'));
    vmax = v.find('-isa','Stateflow.Data','-and','Name','V_MAX');
    set(vmax.Props,'InitialValue',int2str(2.5+rand));
end

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

% configure simulink model parameters
hws = get_param(bdroot, 'modelworkspace');
assignin(hws, 'WORLD_SIZE', wsize);
assignin(hws, 'LANE_WIDTH', lwidth);
assignin(hws, 'LANE_NUM', lnum);
assignin(hws, 'ROAD_WIDTH', lnum*lwidth);

rwidth = lwidth*lnum;
if mod(lnum,2) == 0
    pos_y = -1*(rwidth/2-0.5):1:(rwidth/2-0.5);
else
    pos_y = -1*(rwidth/2):1:(rwidth/2);
end
pos_x = -wsize:1:(wsize-1);

pos = combvec(pos_x, pos_y);
x = [pos(:, 1) pos(:,randsample(2:size(pos,2),num-1))];
% x = [randsample(pos_x,num); randsample(pos_y,num)];
v = zeros(2,num);
d = [ones(1,num);zeros(1,num)];

X = getSimulinkBlockHandle(strcat(mdl,'/Position'));
V = getSimulinkBlockHandle(strcat(mdl,'/Velocity'));
D = getSimulinkBlockHandle(strcat(mdl,'/Orientation'));

set_param(X,'InitialValue',mat2str(x));
set_param(V,'InitialValue',mat2str(v));
set_param(D,'InitialValue',mat2str(d));

end