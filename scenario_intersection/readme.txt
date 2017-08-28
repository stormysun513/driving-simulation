This subfolder includes the simulink model that is able to deal with 
driving behavior in an road intersection. There is a threshold distance set
to determine whether a car is close to the intersection. Once it enters this
region, it respond to traffic light and pedestrian events accordingly.


Two type of inputs are implemented in this model. One is the traffic light
and the other is the pedestrian. Current communication mechanism among these
units are shared memory. If someone works one the future version, one may 
consider using a message passing mechanism to have a more robust behavior.


One can simulate the roadIntersection model by running the simulation script.
A window will pop up and play the simulation result. 


in the window, one can see that each vehicle is labeled with a number and
there is a detection region in front of the car. the detection algorithm 
and priority will slightly change when the driving state changes. The gui
here accept the out put form the simulink and visualize how the detaction
region is changed in the model. Only vehilcle one is the autonomous drving
car, which means it is the most intelligent one while others are just dummy
or a simple agent that do not respond to the environment well. One can see
that they may bump into pedestrian. This model are intermidiate models when 
 i am refractoring of the model design. The logic of this vehicle is not
that important and one can decide whether to replace them in the future


One can replay the simulation result by running the replay script, which
use the variables in the workspace and relay result of last simulation


There is a libraries.slx file here, it is a library of subcharts. This one
the legacy file while I am doing this project. I try to make those substates
with similar function parameterized and be able to reused in the future.
However, due to the limitation of simulink, one can only pass the top level
variables in the statechart block model into the subcharts as arguments, which
is not helpful in some cases. 