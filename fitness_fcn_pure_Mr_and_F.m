function loss = fitness_fcn_pure_Mr_and_F(x,Thruster_Params,Fr_target,F_target);
%FITNESS_FCN_MR_AND_F specific to moments
%function mse = fitness_fcn_control_system(x,y,Control_Params, Model_Params);
%   Inputs: 
%       x = adjustable parameters 
%       Thruster_Params = Thruster Parameters Data Structure
%       Fr_target = target resultant force e.g [0; 0; 1] Mrz = 1 Nm
%       F_target = target thruster force e.g. [0;0;0;0] = no thrust
%
%   Outputs
%       loss = Output of the fitness function (lower = better)
%
%Change Optimization Parameters
Thruster_Params(1).thrust = x(1);
Thruster_Params(2).thrust = x(2);
Thruster_Params(3).thrust = x(3);
Thruster_Params(4).thrust = x(4);
Thruster_Params(5).thrust = x(5);
Thruster_Params(6).thrust = x(6);

%Calculate Forces
Fr = calc_force_3D(Thruster_Params);

%Calculate Loss Function
%Resultant Forces Error
mse_Fr = (norm(Fr-Fr_target))^2;

%Input Forces Error
Thruster_Count = length(Thruster_Params);
F = zeros(Thruster_Count,1);
index = 0;
while(index<Thruster_Count)
    index = index + 1;
    F(index) = Thruster_Params(index).thrust;
end
%mse_F = (sum(abs(F-F_target)))^2;
mse_F = (norm(F-F_target))^2;

%Standard Deviation of Thrusts
%std_F = std(F);
std_F = std(abs(F(1:4)));

%loss=1E9*mse_Fr+1E6*mse_F+10*std_F; %Calculate loss function 
loss=1E9*mse_Fr+1E6*mse_F+1E9*std_F; %Calculate loss function 
