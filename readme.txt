This is the root directory of the statechart simulation project. Three 
simulation scenario are implemented. Each of them has a statechart model
that simulates the behavior of an antonomous vehicle in a specific 
scenario. The following is a list of scenario:


1. intersection
2. lane change in multi-lanes
3. lane change in two lanes
4. lane change in urban
5. parallel parking on the street


One can check the fourth scenarion for a complete walkthrough of model design
and implmentation.


Most of the simulink models take advantage of heirachical statechart to
deal with environment inputs. I adopt a heirachical statchart combined with
message passing mechanism to design the model. The entire intelligent driving
agent is composed of decision units and control units. While the decision unit
is calculating the next step, the control unit takes its job and keep respond
to other message without being blocked.

In general, there are a few design rationale here.


1. separate control unit and decision unit so as the vehile are always under
control

2. use parallel decision units (e.g. FrontCarResponse unit and LaneChange unit)
to simplify the implementation and debug. If someone try to use a large 
heirachical model to encompass all decision unit, it has some negative impact.
First, they are highly coupled, which means any modificaiton in a subchart may
affect the other part. 

3 these substates may have some simular features, one has to create several 
copies, which impacts the maintainability. The last one is friendly to 
distributed development. On account of decoupled units, one developer can 
takes on their own part and integrate later. 

4. Model design in a GUI environment is always painful especially for version 
control. Matlab has translated these gui components into a set of id that 
facilitates its operations but unfriendly for manual merging.


In addition, there are two files in the directory. 


environ/    - file includes all matlab gui related files, it is constructed
              in an object oriented way

backup/     - used to stored intermidiate model based on the date. keep this
              file so that one can uses it for those not intelligent enough
              car for simulation


