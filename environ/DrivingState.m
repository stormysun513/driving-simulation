%{ 

file: DrivingState.m
author: yu lun tsai
date: Aug 15, 2017
email: stormysun513@gmail.com

A Simulink enum type object that is used in simulation to distinguish 
different driving state and modify the gui accordingly

%}

classdef DrivingState < Simulink.IntEnumType
    enumeration
        Straight(0);
        RightTurn(1);
        LeftTurn(2);
    end
end