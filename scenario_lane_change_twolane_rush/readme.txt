This subfolder includes the lane change stateflow model. This model behaves
aggressively when there is a front car blocking its way. A high-levle 
decision unit is running concurrently with the vehicle decision unit. They
both send message to the control unit to alter the behavior of the vehicle.
Ideally, three components are running in parallel. However, simulink 
simulation runs them concurrently. It may have some weird behaviors. 

One can simulate parallel parking by running the simulation script. A
figure window will pop up and play the simulation result. 

One can replay the simulation result by running the replay script, which
use the variables in the workspace and relay result of last simulation