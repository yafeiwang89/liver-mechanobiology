
clear parameters 

parameters.domain_edge_length = 10000; 
parameters.dx = 20; 
parameters.spatial_units = 'um'; 
parameters.lobule_radius = 400; 
parameters.min_central_vein_spacing = 1.5 * parameters.lobule_radius; 


parameters.central_vein_radius = 26.5; 
parameters.portal_triad_radius = 23.0; 
parameters.parenchyme_radius = 15; 

% flow parameters 

parameters.flow_rate = 1e4; % 500 * 60; % micron / min 
parameters.outlet_flow = 6e4 
parameters.inlet_to_outlet_flow_ratio = 0.05;
parameters.flow_a = parameters.outlet_flow; 
parameters.flow_b = 0.0075; % -log( parameters.inlet_to_outlet_flow_ratio ) / parameters.lobule_radius 
% hard-coded to match the paper

% o2 parameters

parameters.oxygen_units = 'mmHg'; 

parameters.o2_uptake_rate = 10; % 1/min 
parameters.outlet_o2 = 38.9; 
parameters.o2_param = 0.0223; % parameters.o2_uptake_rate / ( parameters.flow_a * parameters.flow_b ) 
% hard-coded to match the paper 
parameters.o2_c = parameters.outlet_o2;

parameters.min_oxygen = parameters.outlet_o2; % 32.5; 
parameters.max_oxygen = 65; % 60; 
parameters.cap = true; % don't let o2 exceed parameters.max_oxygen 
% don't let o2 fall below parameters.min_oxygen 






