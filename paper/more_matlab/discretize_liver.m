tic
% Voronoi tesselation of the central veins
[VX,VY] = voronoi( central_vein_positions(:,1)  , central_vein_positions(:,2)  , 'b'  ); 
toc 
pause(1e-10); 

% use the voronoi tesselation to figure out the portal triad positions 
portal_triad_positions = zeros(length(VX),2 ); 
n = 1; 

for i=1:length(VX)
    pt = [VX(1,i) , VY(1,i)];
    if( abs( pt(1) ) <= parameters.domain_edge_length /2.0 && abs( pt(2) ) <= parameters.domain_edge_length /2.0 )
        portal_triad_positions(n,:) = pt; 
        n = n+1; 
    end   
end

portal_triad_positions = portal_triad_positions(1:n-1 , : ); 

toc 
pause(1e-10); 

parameters.parenchyme_spacing = parameters.parenchyme_radius * sqrt( (2*pi) / sqrt(3) ); 

% now, create a hexagonal arrangement of parenchyme agents 
position = parameters.domain_edge_length/2.0 * [-1,-1]; 
position = position + parameters.parenchyme_radius *[1,1]; 
n =1; 

row= 1; 

position_x_odd = position(1); 
% position_x_even = position(1) - parameters.parenchyme_radius; 
position_x_even = position(1) - parameters.parenchyme_spacing/2.0; 

% pre-compute typical size ; 
number_of_cells = floor( (parameters.domain_edge_length^2) / (pi * parameters.parenchyme_radius^2 ) ) ; 
parenchyme_positions = [number_of_cells,1]; 
toc 
pause(1e-10); 

while( position(2) < parameters.domain_edge_length/2.0 )

    while( position(1) < parameters.domain_edge_length/2.0  )
        
        add_me = true; 
        
        stop = false; 
        j = 1; 
        while( j <= length(central_vein_positions ) )
            if( norm( position - central_vein_positions(j,:) ) < parameters.central_vein_radius + parameters.parenchyme_radius )
                % parenchyme_spacing
                add_me = false; 
                stop = true; 
            end
            j = j+1; 
        end
        
        stop = false; 
        j = 1; 
        while( j <= length(portal_triad_positions ) )
            if( norm( position - portal_triad_positions(j,:) ) < 0.75*( parameters.portal_triad_radius + parameters.parenchyme_radius ) )
                % parenchyme_spacing
                add_me = false; 
                stop = true; 
            end
            j = j+1; 
        end        
        
        
        if( add_me )
            parenchyme_positions(n,:) = position;
            n = n+1; 
        end

       position(1) = position(1) + parameters.parenchyme_spacing; %  2*parameters.parenchyme_radius;  
    end

    position(2) = position(2) + sqrt(3)*parameters.parenchyme_spacing/2.0; %  parameters.parenchyme_radius; 
    
    row = row+1; 
    if( mod(row,2) == 0 )    
        position(1) = position_x_even; 
    else
        position(1) = position_x_odd;
    end
end
toc 
pause(1e-10) 

% trim unused rows 
parenchyme_positions = parenchyme_positions(1:n-1 , : ); 

toc
pause(1e-10); 

plot_discretized_liver(); 

toc
pause(1e-10); 
