this directory includes all matlab objects used to construct the gui 
environment. oone can assign the environment configuraiton when calling the
constructor or change their values later by calling some set function. A 
typical use cases is to update the position of an object. for example, 

car.setPos(new_pos);
car.setPosDir(new_pos, new_dir);

are used to update the car status. at each display iteration, one can call 

env.draw() 

to update the gui, it will then call all the objects' draw methods. one must
note that any updates of locations or statuses must be completed before
calling draw function.