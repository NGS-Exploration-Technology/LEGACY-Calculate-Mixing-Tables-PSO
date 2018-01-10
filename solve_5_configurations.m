%A) Standard ROV
solution_name = 'Standard ROV';
Thruster_Params = setup_calc_force_3D_standard_ROV;
calculate_thruster_table_pso_script(solution_name, Thruster_Params);

%B) Standard ROV Side Corkscrew
solution_name = 'Standard ROV Side Corkscrew';
Thruster_Params = setup_calc_force_3D_standard_ROV_side_corkscrew;
calculate_thruster_table_pso_script(solution_name, Thruster_Params);

%C) Standard ROV Full Vector
solution_name = 'Standard ROV Full Vector';
Thruster_Params = setup_calc_force_3D_standard_ROV_full_vector;
calculate_thruster_table_pso_script(solution_name, Thruster_Params);

%D) Standard ROV Front Corkscrew
solution_name = 'Standard ROV Front Corkscrew';
Thruster_Params = setup_calc_force_3D_standard_ROV_front_corkscrew;
calculate_thruster_table_pso_script(solution_name, Thruster_Params);

%E) UFO
solution_name = 'UFO';
Thruster_Params = setup_calc_force_3D_UFO;
calculate_thruster_table_pso_script(solution_name, Thruster_Params);