classdef DrivingState < Simulink.IntEnumType
  enumeration
    Straight(0);
    RightTurn(1);
    LeftTurn(2);
  end
end