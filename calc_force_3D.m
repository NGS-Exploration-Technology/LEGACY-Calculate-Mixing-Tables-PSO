function [Fr] = calc_force_3D(Thruster_Params)
%CALC_FORCE_2D Calculate result force and moment of an arbitrary thruster
%configuration.
%
%function [Fr] = calc_force_3D(Thruster_Params)
%inputs:
%   Thruster_Params = input data structure from setup_calc_force_3D
%   
%outputs:
%   Fr = [Frx]  [N] Resultant force on the ROV in the x direction
%        [Fry]  [N] Resultant force on the ROV in the y direction
%        [Frz]  [N] Resultant force on the ROV in the z direction
%        [Mrx]  [Nm] Resultant moment about x (roll moment)
%        [Mry]  [Nm] Resultant moment about y (pitch moment)
%        [Mrz]  [Nm] Resultant moment about z (yaw moment)
%
%See also SETUP CALC FORCE 3D

%Calculate Resultant Force and Moment from an Arbitrary Thruster
%Configuration
%
%Note for vectors index 1 = x, 2 = y, and 3 = z

Thruster_Count = length(Thruster_Params);

%Build H Matrix 
%
%  Fr = H*F

%Build H
Hf = zeros(3,Thruster_Count);
%Extract thruster direction unit vectors from Thruster struct
u_hat = zeros(3,Thruster_Count);
index = 0;
while(index<Thruster_Count)
    index = index + 1;
    u_hat(1,index) = cos(Thruster_Params(index).yaw_angle*pi/180)*cos(Thruster_Params(index).pitch_angle*pi/180); %Unit vector x component (calculated from angles)
    u_hat(2,index) = sin(Thruster_Params(index).yaw_angle*pi/180)*cos(Thruster_Params(index).pitch_angle*pi/180); %Unit vector y component (calculated from angles)
    u_hat(3,index) = sin(Thruster_Params(index).pitch_angle*pi/180); %Unit vector z component (calculated from pitch angles)
end

%Add Thruster unit vector force directions to Hf
index = 0;
while(index<Thruster_Count)
    index = index + 1;
    Hf(:,index) = u_hat(:,index);
end


%Calculate Moment directions - Cross Products of Thruster Direction and Location Vectors
Hm = zeros(3, Thruster_Count);

%Extract thruster location vectors from Thruster struct
d_hat = zeros(3, Thruster_Count);
index = 0;
while(index<Thruster_Count)
    index = index + 1;
    d_hat(:,index) = Thruster_Params(index).position;
end

index = 0;
while(index<Thruster_Count)
    index = index + 1;
    Hm(:,index) = cross(d_hat(:,index), u_hat(:,index));
end

%Combine Hf and Hm into H
H=[Hf;Hm];

%Build F
%Extract Thruster Forces
F = zeros(Thruster_Count,1);
index = 0;
while(index<Thruster_Count)
    index = index + 1;
    F(index) = Thruster_Params(index).thrust;
end

%Calculate Fr = H*F
Fr = H*F;