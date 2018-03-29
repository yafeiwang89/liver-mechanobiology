
parameters.domain_edge_length = 10000; 
parameters.dx = 20; 
parameters.spatial_units = 'um'; 
parameters.lobule_radius = 400; 
parameters.min_central_vein_spacing = 1.5 * parameters.lobule_radius; 


parameters.central_vein_radius = 26.5; % email 
parameters.portal_triad_radius = 23.0; 
parameters.parenchyme_radius = 15; 


parameters.min_oxygen = 32.5; 
parameters.max_oxygen = 65; 
parameters.oxygen_units = 'mmHg'; 
parameters.flow_rate = 500 * 60; % micron / min 
parameters.uptake_rate = 10; % 1/min 

[X,Y,central_vein_positions,oxygen,nearest_index,distance_to_nearest_central_vein,s] = test_liver_o2( parameters );


