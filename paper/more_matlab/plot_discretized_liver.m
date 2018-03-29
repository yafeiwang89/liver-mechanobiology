
scale = 1; 
axis_units = '\mum';
if( parameters.domain_edge_length > 1000 ) 
    scale = 1000; 
    axis_units = 'mm'; 
end

figure(6);



clf; 
% plot( parenchyme_positions(:,1) , parenchyme_positions(:,2) ,'ko' ); 
% temp_area = pi*parameters.parenchyme_radius^2; 
R = (parameters.parenchyme_radius/scale) * ones(1,length(parenchyme_positions)  ); 
plot_circle( (1/scale)*parenchyme_positions' ,  R , 'fillcolor', [.85 .5 .25] , 'edgecolor', 'none'); 
% scatter( parenchyme_positions(:,1) , parenchyme_positions(:,2) , temp_area , 'g', 'filled' ); 
hold on ; 
% plot( portal_triad_positions(:,1) , portal_triad_positions(:,2) , 'ro' ); 
R = (parameters.portal_triad_radius/scale) * ones(1,length(parenchyme_positions) ); 
plot_circle( (1/scale)*portal_triad_positions' ,  R , 'fillcolor', [1 0 0] , 'edgecolor', 'none'); 

% plot( central_vein_positions(:,1) , central_vein_positions(:,2) , 'bo' ); 
R = (parameters.central_vein_radius/scale) * ones(1,length(parenchyme_positions) ); 
% plot_circle( (1/scale)*central_vein_positions' ,  R , 'fillcolor', [0 0 1] , 'edgecolor', 'none' ); 
hold off; 
axis image 

size( parenchyme_positions )
size( central_vein_positions )
size( portal_triad_positions )

axis( (parameters.domain_edge_length/scale)*0.5*[-1,1,-1,1]); 

set( gca, 'fontsize', 13 ); 
txt = sprintf('Discretized liver in a %2.2f %s^2 liver slice', area , units )
title( txt , 'fontsize', 14 ); 

axis_label = sprintf( 'x (%s)', axis_units );
xlabel( axis_label , 'fontsize', 13 ); 
axis_label = sprintf( 'y (%s)', axis_units );
ylabel( axis_label , 'fontsize', 13 ); 
set( gca, 'fontsize', 13 ); 


