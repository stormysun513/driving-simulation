This subfolder includes the model for the third use case of lane changing.
It aims to simulate a case that an adjacent lane is full of cars and the
autonomous car would like to cutoff into the lane

One can simulate parallel parking by running the simulation script. A
figure window will pop up and play the simulation result. 

One can replay the simulation result by running the replay script, which
use the variables in the workspace and relay result of last simulation


There are multiple files under this directory.


configModel.m - used to programmatically update or change the parameters 
                or the initial values, one can edit this file to do further
                customization

Decison.m     - a simulink enum type object used in the statechart model. 
                In this case, it is used to identify whether a car decide 
                to do the lane change of remain straight on the current 
                lane. it must be placed at the same place as the model file

*.slx         - the simulink model file

simulation.m  - the script for running the simulation