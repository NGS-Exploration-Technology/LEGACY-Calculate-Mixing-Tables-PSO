function [Fr_out, F_out, fval_out] = pso_solve_forces(Thruster_Params, Fr_target, F_target)
%PSO SOLVE FORCES Calculate result force and moment of an arbitrary thruster
%configuration.
%
%function [Fr, F] = pso_solve_forces(Fr_target, F_target)
%inputs:
%   Thruster_Params = Thruster parameters
%   Fr_target = Resultant Forces to Solve For
%   F_target = Ideal Thrusts to aim for
%   
%outputs:
%   Fr = [Frx]  [N] Resultant force on the ROV in the x direction
%        [Fry]  [N] Resultant force on the ROV in the y direction
%        [Frz]  [N] Resultant force on the ROV in the z direction
%        [Mrx]  [Nm] Resultant moment about x (roll moment)
%        [Mry]  [Nm] Resultant moment about y (pitch moment)
%        [Mrz]  [Nm] Resultant moment about z (yaw moment)
%
%   F = [F1 - F6] = Thrusts from individual thrusters
%
%See also SETUP CALC FORCE 3D and CALC FORCE 3D

%Calculate Resultant Force and Moment from an Arbitrary Thruster
%Configuration using particle swarm optimization
%
%Note for vectors index 1 = x, 2 = y, and 3 = z

%add psopt as a path
addpath(strcat(pwd, '\psopt'))

%Set pso options
options.CognitiveAttraction = 0.5;
options.ConstrBoundary = 'penalize';
options.AccelerationFcn = @psoiterate;
options.DemoMode = 'pretty';
options.Display = 'final';
options.FitnessLimit = -Inf;
options.Generations = 100000;
options.KnownMin = [];
options.PlotFcns = {[@psoplotswarm]  [@psoplotbestf]};
options.PlotInterval = 1;
options.PopulationSize = 40;
options.SocialAttraction = 1.00;
options.StallGenLimit = Inf;
options.StallTimeLimit = Inf;
options.TimeLimit = 60;
%options.TimeLimit = 60;
options.TolCon = 1.0000e-9;
options.TolFun = 1.0000e-9;
options.UseParallel = 'never';
options.Vectorized = 'off';
options.VelocityLimit = [];

%define Fitness Function
f = @(x)fitness_fcn_Fr_and_F(x,Thruster_Params, Fr_target, F_target);

nvars = 6;
LB = [-3, -3, -3, -3, -3, -3];
UB = [3, 3, 3, 3, 3, 3];
%run the optimizer
[x fval_out exitflag opt_output] = pso(f,nvars, [],[],[],[],LB,UB,[],options)

%Calculate Result and Plot
Thruster_Params(1).thrust = x(1);
Thruster_Params(2).thrust = x(2);
Thruster_Params(3).thrust = x(3);
Thruster_Params(4).thrust = x(4);
Thruster_Params(5).thrust = x(5);
Thruster_Params(6).thrust = x(6);

Fr_out = calc_force_3D(Thruster_Params);

%Extract Thruster Forces
Thruster_Count = length(Thruster_Params);
F_out = zeros(6,1);
index = 0;
while(index<Thruster_Count)
    index = index + 1;
    F_out(index) = Thruster_Params(index).thrust;
end

