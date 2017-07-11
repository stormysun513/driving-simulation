function configModel(mdl, params)

num = params('NUM_OF_CARS');

if(num <= 0)
    return;
end

rt = sfroot;
m = rt.find('-isa','Simulink.BlockDiagram','-and','Name',mdl);

% remove existing vehicles
charts = m.find('-isa','Stateflow.Chart');
v1 = m.find('-isa','Stateflow.Chart','-and','Name','Vehicle1');
stack = cell(length(charts),1);
count = 0;
for i=1:length(charts)
    ch = charts(i);
    if startsWith(ch.Name,'Vehicle') && ~strcmp(ch.Name,v1.Name)
        count = count + 1;
        stack{count} = ch.Path;
    end
end

for i=1:count
    path = stack{i};
    delete_block(path);
end

% generate rendom strategy
% [~, options] = enumeration('Decision');
% numOfDecision = length(options);

% create vehicles
position = get_param(v1.Path,'Position');
base = v1.Path(1:length(v1.Path)-1);
for i=2:num
    idx = int2str(i);
    path = strcat(base,idx);
    position(2) = position(2) + 90;
    position(4) = position(4) + 90;
    add_block(v1.Path,path,'Position',position);
   
    v = m.find('-isa','Stateflow.Chart','-and','Path',path);
    candidates = v.find('-isa','Stateflow.Data','-and','Name','this');
    this = findobj(candidates,'Path',path);
    set(this.Props,'InitialValue',strcat('uint8(',idx,')'));
    
%     candidates = v.find('-isa','Stateflow.Data','-and','Name','decision');
%     decision = findobj(candidates,'Path',path);
%     set(decision.Props,'InitialValue', strcat('Decision.', options{randi(numOfDecision)}));
end

% initialize some internal parameters
pos = -8:7;
pos = pos(pos > 1 | pos < -1);
x = [randsample(pos,num); -0.5*ones(1,num)];
v = zeros(2,num);
d = [ones(1,num);zeros(1,num)];
% size = repmat([0.3, 0.4], num, 1);

X = getSimulinkBlockHandle('experiment/Position');
V = getSimulinkBlockHandle('experiment/Velocity');
D = getSimulinkBlockHandle('experiment/Orientation');

set_param(X,'InitialValue',mat2str(x));
set_param(V,'InitialValue',mat2str(v));
set_param(D,'InitialValue',mat2str(d));


