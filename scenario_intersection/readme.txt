This subfolder includes the simulink model that is able to deal with 
driving behavior in an road intersection. There is a threshold distance set
to determine whether a car is close to the intersection. Once it enters this
region, it accepts the environment inputs and act accordingly.

Two type of inputs are implemented in this model. One is the traffic light
and the other is the pedestrian. Current communication mechanism among these
units are shared memory. If someone works one the future version, one may 
consider using a message passing mechanism to have a more robust behavior.


One can simulate parallel parking by running the simulation script. A
figure window will pop up and play the simulation result. 


One can replay the simulation result by running the replay script, which
use the variables in the workspace and relay result of last simulation