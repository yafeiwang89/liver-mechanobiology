units = '\mum'; 
area = parameters.domain_edge_length^2; 
if( area > 99 )
    area = area / (1000*1000); 
    units = 'mm';
end
if( area > 99 )
    area = area / (10*10); 
    units='cm'; 
end


figure(1); 
clf

contourf( X,Y,nearest_index' ); 
axis square 
% axis( domain_edge_length*.5*[-1 1 -1 1] ); 
hold on 
plot( central_vein_positions(:,1) , central_vein_positions(:,2) ,'ko' ,'markerfacecolor', 'w', 'markeredgecolor', 'w' , 'markersize' , 10);
plot( central_vein_positions(:,1) , central_vein_positions(:,2) ,'ko' ,'markerfacecolor', 'k', 'markeredgecolor', 'k' , 'markersize' , 8 );
hold off

figure(2); 
clf

contourf( X,Y,distance_to_nearest_central_vein' ); 
axis square 
% axis( domain_edge_length*.5*[-1 1 -1 1] ); 
hold on 
plot( central_vein_positions(:,1) , central_vein_positions(:,2) ,'ko' ,'markerfacecolor', 'w', 'markeredgecolor', 'w' , 'markersize' , 10);
plot( central_vein_positions(:,1) , central_vein_positions(:,2) ,'ko' ,'markerfacecolor', 'k', 'markeredgecolor', 'k' , 'markersize' , 8 );
hold off

figure(3); 
clf

contourf( X,Y,oxygen' ); 
axis square 
% axis( domain_edge_length*.5*[-1 1 -1 1] ); 
hold on 
plot( central_vein_positions(:,1) , central_vein_positions(:,2) ,'ko' ,'markerfacecolor', 'w', 'markeredgecolor', 'w' , 'markersize' , 10);
plot( central_vein_positions(:,1) , central_vein_positions(:,2) ,'ko' ,'markerfacecolor', 'k', 'markeredgecolor', 'k' , 'markersize' , 8 );
hold off

figure(4);
clf
surf( X , Y, oxygen' , 'edgecolor', 'none'  ); 
view([0 90]);
axis image
colormap( 'copper' ); 
shading('interp'); 
colorbar
hold on 
plot( central_vein_positions(:,1) , central_vein_positions(:,2) ,'ko' ,'markerfacecolor', 'w', 'markeredgecolor', 'w' , 'markersize' , 10);
plot( central_vein_positions(:,1) , central_vein_positions(:,2) ,'ko' ,'markerfacecolor', 'k', 'markeredgecolor', 'k' , 'markersize' , 8 );
hold off


figure(5);

scale = 1; 
axis_units = '\mum';
if( parameters.domain_edge_length > 1000 ) 
    scale = 1000; 
    axis_units = 'mm'; 
end

clf
contourf( X/scale , Y/scale, oxygen' , 30, 'edgecolor', 'none'  ); 
axis image
colormap( 'bone' ); 
colorbar
hold on 
% plot( central_vein_positions(:,1)/scale , central_vein_positions(:,2)/scale ,'ko' ,'markerfacecolor', 'w', 'markeredgecolor', 'w' , 'markersize' , 10);
% plot( central_vein_positions(:,1)/scale , central_vein_positions(:,2)/scale ,'ko' ,'markerfacecolor', 'k', 'markeredgecolor', 'r' , 'markersize' , 8 );
h = voronoi( central_vein_positions(:,1)/scale , central_vein_positions(:,2)/scale , 'r'  ); 
set( h , 'linewidth', 2 ) ; 
set( h , 'MarkerEdgeColor', 'g' ); 
hold off
set( gca, 'fontsize', 13 ); 
txt = sprintf('Oxygen (mmHg) in a %2.2f %s^2 liver slice', area , units )
title( txt , 'fontsize', 14 ); 

axis_label = sprintf( 'x (%s)', axis_units );
xlabel( axis_label , 'fontsize', 13 ); 
axis_label = sprintf( 'y (%s)', axis_units );
ylabel( axis_label , 'fontsize', 13 ); 
set( gca, 'fontsize', 13 ); 


