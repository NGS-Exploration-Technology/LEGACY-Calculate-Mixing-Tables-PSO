function calculate_thruster_table_pso(solution_name, Thruster_Params)
%CALC_FORCE_3D Calculate result force and moment of an arbitrary thruster
%configuration.
%
%function calculate_thruster_table_pso(solution_name, Thruster_Params)
%inputs:
%   solution_name   = string containing name of this solution
%   Thruster_Params = input data structure from setup_calc_force_3D
%   
%outputs:
%
%See also PSO_SOLVE_FORCES, SETUP_CALC_FORCE_3D

%Calculate Resultant Force and Moment from an Arbitrary Thruster
%Configuration
%
%Note for vectors index 1 = x, 2 = y, and 3 = z
clear all
tic

%Add current directory to search path
current_directory = cd;
addpath(current_directory);

%Record thruster setup
[Thruster_Params_out] = setup_calc_force_3D();

%Define resultant forces to solve
Fr_target_table(1,:) = [1 0 0 0 0 0]; %1N in the x direction
Fr_target_table(2,:) = [0 1 0 0 0 0]; %1N in the y direction
Fr_target_table(3,:) = [0 0 1 0 0 0]; %1N in the z direction
Fr_target_table(4,:) = [0 0 0 1 0 0]; %1Nm in the x direction
Fr_target_table(5,:) = [0 0 0 0 1 0]; %1Nm in the x direction
Fr_target_table(6,:) = [0 0 0 0 0 1]; %1Nm in the z direction

%Define target thrusts
F_target_table(1,:) = [0 0 0 0 0 0]; %Target thrusts for Fr row 1
F_target_table(2,:) = [0 0 0 0 0 0]; %Target thrusts for Fr row 2
F_target_table(3,:) = [0 0 0 0 0 0]; %Target thrusts for Fr row 3
F_target_table(4,:) = [0 0 0 0 0 0]; %Target thrusts for Fr row 4
F_target_table(5,:) = [0 0 0 0 0 0]; %Target thrusts for Fr row 5
F_target_table(6,:) = [0 0 0 0 0 0]; %Target thrusts for Fr row 6

%Initialize Variables
Solution_Count = 6;
Thruster_Count = 6;
Fr_target = zeros(6,1);
Fr_out = Fr_target;
fval_out = zeros(Solution_Count,1);
F_target = zeros(Thruster_Count,1);
F_out = F_target;

Fr_output_table = zeros(size(Fr_target_table));
F_output_table = zeros(size(F_target_table));

%Solve for force table
index = 0;
while(index<Solution_Count)
    index = index + 1;
    Fr_target = Fr_target_table(index,:)';
    F_target = F_target_table(index,:)';
    [Fr_out, F_out, fval_out(index)] = pso_solve_forces(Fr_target, F_target);
    %Add outputs to table
    Fr_output_table(index,:) = Fr_out';
    F_output_table(index,:) = F_out';
end

%save output to csv files and thruster setup
cd Outputs
%Fr
Solution_Number = [1:Solution_Count]';
Fr_output_table = [Solution_Number Fr_output_table Fr_target_table fval_out];

clock_time = clock;
date_time = date;
filename_Fr = [date_time ' ' num2str(clock_time(4)) num2str(clock_time(5)) ' ' solution_name ' Fr pso.csv'];
headers_Fr = {'Solution', 'Frx', 'Fry', 'Frz', 'Mrx', 'Mry', 'Mrz', 'Frx target', 'Fry target', 'Frz target', 'Mrx target', 'Mry target', 'Mrz target', 'fval'};
csvwrite_with_headers(filename_Fr, Fr_output_table, headers_Fr);

%F
F_output_table = [Solution_Number F_output_table F_target_table fval_out];
filename_F = [date_time ' ' num2str(clock_time(4)) num2str(clock_time(5)) ' ' solution name ' F pso.csv'];
headers_F = {'Solution', 'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F1 target', 'F2 target', 'F3 target', 'F4 target', 'F5 target', 'F6 target', 'fval'};
csvwrite_with_headers(filename_F, F_output_table, headers_F);

%Thruster Setup
filename_Fsetup = [date_time ' ' num2str(clock_time(4)) num2str(clock_time(5)) ' ' solution name ' Fsetup pso.mat'];
runtime = toc;
save(filename_Fsetup);

%return to root directory and remove current directory from search path
cd ..
rmpath(current_directory);
