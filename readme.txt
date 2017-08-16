This is the root directory of the statechart simulation project. Three 
simulation scenario are implemented. Each of them has a statechart model
that simulate the behavior of an antonomous vehicle in the specific 
scenario.

1. intersection
2. lane change in multi-lanes
3. lane change in two lanes
4. lane change in urban
5. parallel parking on the street

Besides folders related to different scenario, there are two files in the 
directory

environ/    - file includes all matlab gui related files, it is constructed
              in an object oriented way

backup/     - used to stored intermidiate model based on the date. keep this
              file so that one can uses it for those not intelligent enough
              car for simulation