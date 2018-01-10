function [Thruster_Params] = setup_calc_force_3D_side_corkscrew()
%SETUP_CALC_FORCE_3D Generate input data structures for sim_ROV_3D
%function [Thruster_Params] = setup_calc_force_3D()
%inputs:
%   none
%outputs:
%   Thruster_Params = input data structure for calc_force_3D
%
%See also CALC FORCE 3D

%Initialize Variables
Thruster_Count = 6;
index = 0;
while(index<Thruster_Count)
    index = index + 1;
    Thruster_Params(index).position = zeros(3,1); %[m] Location vector of thruster
    Thruster_Params(index).yaw_angle = 0; %[deg] Thruster yaw angle from x
    Thruster_Params(index).pitch_angle = 0; %[deg] Thruster pitch angle from xy plane
    Thruster_Params(index).thrust = 0; %[N] Thrust
end

%Define Thruster Configuration (index for Thruster_Params is Thruster ID)
    %Thruster 1
    Thruster_Params(1).position(1)= 0.5; %[m] x Location of Thruster on frame WRT center of mass
    Thruster_Params(1).position(2) = 0.5; %[m] y Location of Thruster on frame
    Thruster_Params(1).position(3) = 0; %[m] z Location of Thruster on frame
    Thruster_Params(1).yaw_angle = -30; %[deg] Angle of Thruster from X
    Thruster_Params(1).pitch_angle = 30; %[deg] Angle of Thruster from XY plane
    %Thruster_Params(1).thrust = -.422; %[N] Force imparted by thruster
    Thruster_Params(1).thrust = 0; %[N] Force imparted by thruster
    %Thruster 2
    Thruster_Params(2).position(1) = 0.5; %[m] x Location of Thruster on frame
    Thruster_Params(2).position(2) = -0.5; %[m] y Location of Thruster on frame
    Thruster_Params(2).position(3) = 0; %[m] z Location of Thruster on frame
    Thruster_Params(2).yaw_angle = 30; %[deg] Angle of Thruster from X
    Thruster_Params(2).pitch_angle = 30; %[deg] Angle of Thruster from XY plane
    %Thruster_Params(2).thrust = 0.422; %[N] Force imparted by thruster
    Thruster_Params(2).thrust = 0; %[N] Force imparted by thruster
    %Thruster 3
    Thruster_Params(3).position(1) = -0.5; %[m] x Location of Thruster on frame
    Thruster_Params(3).position(2) = -0.5; %[m] y Location of Thruster on frame
    Thruster_Params(3).position(3) = 0; %[m] z Location of Thruster on frame
    Thruster_Params(3).yaw_angle = -30; %[deg] Angle of Thruster from X
    Thruster_Params(3).pitch_angle = 30; %[deg] Angle of Thruster from XY plane
    %Thruster_Params(3).thrust = 0.422; %[N] Force imparted by thruster
    Thruster_Params(3).thrust = 0; %[N] Force imparted by thruster
    %Thruster 4
    Thruster_Params(4).position(1) = -0.5; %[m] x Location of Thruster on frame
    Thruster_Params(4).position(2) = 0.5; %[m] y Location of Thruster on frame
    Thruster_Params(4).position(3) = 0; %[m] z Location of Thruster on frame
    Thruster_Params(4).yaw_angle = 30; %[deg] Angle of Thruster from X
    Thruster_Params(4).pitch_angle = -30; %[deg] Angle of Thruster from XY plane
    %Thruster_Params(4).thrust = -0.422; %[N] Force imparted by thruster
    Thruster_Params(4).thrust = 0; %[N] Force imparted by thruster
    %Thruster 5
    Thruster_Params(5).position(1) = 0.5; %[m] x Location of Thruster on frame
    Thruster_Params(5).position(2) = 0; %[m] y Location of Thruster on frame
    Thruster_Params(5).position(3) = 0; %[m] z Location of Thruster on frame
    Thruster_Params(5).yaw_angle = 0; %[deg] Angle of Thruster from X
    Thruster_Params(5).pitch_angle = -90; %[deg] Angle of Thruster from XY plane
    Thruster_Params(5).thrust = -0.5; %[N] Force imparted by thruster
    %Thruster 6
    Thruster_Params(6).position(1) = -0.5; %[m] x Location of Thruster on frame
    Thruster_Params(6).position(2) = 0; %[m] y Location of Thruster on frame
    Thruster_Params(6).position(3) = 0; %[m] z Location of Thruster on frame
    Thruster_Params(6).yaw_angle = 0; %[deg] yaw angle of Thruster from X
    Thruster_Params(6).pitch_angle = -90; %[deg] pitch ngle of Thruster from XY plane
    Thruster_Params(6).thrust = 0.5; %[N] Force imparted by thruster
