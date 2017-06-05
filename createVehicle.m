function createVehicle(mdl, num)

if(num <= 1)
    return;
end

rt = sfroot;
m = rt.find('-isa','Simulink.BlockDiagram','-and', 'Name',mdl);
ch = m.find('-isa','Stateflow.Chart');

% remove existing vehicles
v1 = ch.find('-isa','Stateflow.State','-and','Name','Vehicle1');
states = ch.find('-isa','Stateflow.State');
stack = {length(states)};
count = 0;
for i=1:length(states)
    s = states(i);
    if startsWith(s.Name,'Vehicle') && ~strcmp(s.Name, v1.Name)
        count = count + 1;
        stack{count} = s.Name;
    end
end

for i=1:count
    name = stack{i};
    v = ch.find('-isa','Stateflow.State','-and','Name',name);
    v.delete;
end

% create vehicles
cb = sfclipboard;
cb.copy(v1);
position = [600 320 120 90];
for i=2:num
    cb.pasteTo(ch);
    idx = int2str(i);
    name = strcat('Vehicle', idx);
    v = ch.find('-isa','Stateflow.State','-and','Name',name);
    set(v,'Position',position)
    this = v.find('-isa','Stateflow.Data','-and','Name','this');
    set(this.Props,'InitialValue',idx);
    position(2) = position(2) + 120;
end

size = strcat('[',int2str(num),',2]');
X = ch.find('-isa','Stateflow.Data','-and','Name','X');
V = ch.find('-isa','Stateflow.Data','-and','Name','V');
A = ch.find('-isa','Stateflow.Data','-and','Name','A');
D = ch.find('-isa','Stateflow.Data','-and','Name','D');
set(X.Props.Array,'size',size);
set(V.Props.Array,'size',size);
set(A.Props.Array,'size',size);
set(D.Props.Array,'size',size);

% initialize some internal parameters
pos = -8:7;
pos = pos(pos > 1 | pos < -1);
x = [randsample(pos,num)' -0.5*ones(num,1)];
v = zeros(num,2);
a = zeros(num,2);
d = [ones(num, 1) zeros(num,1)];
set(X.Props,'InitialValue',mat2str(x));
set(V.Props,'InitialValue',mat2str(v));
set(A.Props,'InitialValue',mat2str(a));
set(D.Props,'InitialValue',mat2str(d));

