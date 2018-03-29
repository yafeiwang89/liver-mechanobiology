
% This creates the oxygen field (in unobstructed liver tissue), used as 
% far-field conditions in the computational model. 
% 
% It also modifes the liver tissue to eliminate "high o2" regions. 

function [oxygen,nearest_index,distance_to_nearest_central_vein,central_vein_positions] = create_oxygen_field( parameters , X, Y, central_vein_positions )

domain_edge_length = parameters.domain_edge_length; 
dx = parameters.dx; 

Z = 0; 

oxygen_parameter = log( parameters.max_oxygen / parameters.min_oxygen) / parameters.lobule_radius;

% initialize the oxygen field 

oxygen = zeros( length(X) , length(Y) ); 
nearest_index = oxygen; 
distance_to_nearest_central_vein = oxygen; 

params.min_oxygen = parameters.min_oxygen; 
params.oxygen_parameter = oxygen_parameter; 
params.max_oxygen = parameters.max_oxygen; 
params.cap = false; true; 

for i=1:length(X)
    for j=1:length(Y)
        % find closest central vein 
        position = [X(i), Y(j)]; 
        displacements = zeros( number_of_lobules, 2 ); 
        distances = zeros( 1 , number_of_lobules ); 
        for k=1:number_of_lobules          
            displacements(k,:) = central_vein_positions(k,:) - position; 
            distances(k) = norm( displacements(k,:) , 2 ); 
        end
        
        [val,ind] = min( distances ); 
        nearest_index(i,j) = ind(1); 
        distance_to_nearest_central_vein(i,j) = val; 
        
        oxygen(i,j) = o2_radial_profile( val , params ); 
        
    end
end

% and now, pick some empty spots 
% find the N spots with highest O2, and place a central vein there

new_central_veins_count = 40; 

done = false; 
ii = 1; 
while( done == false )
    ii

    max_i = -1;
    max_j = -1;
    max_val =0; 
    for i=1:length(X)
        for j=1:length(Y)
            if( distance_to_nearest_central_vein(i,j) > max_val )
                max_val = distance_to_nearest_central_vein(i,j);
                max_i = i; 
                max_j = j;
            end
        end
    end
    
    n = length( central_vein_positions ); 
    central_vein_positions( n+1 , : )  = [ X(max_i) , Y(max_j) ]; 
    number_of_lobules = number_of_lobules + 1; 
    
    for i=1:length(X)
        for j=1:length(Y)
            % find closest central vein 
            position = [X(i), Y(j)]; 
            displacements = zeros( number_of_lobules, 2 ); 
            distances = zeros( 1 , number_of_lobules ); 
            for k=1:number_of_lobules          
                displacements(k,:) = central_vein_positions(k,:) - position; 
                distances(k) = norm( displacements(k,:) , 2 ); 
            end

            [val,ind] = min( distances ); 
            nearest_index(i,j) = ind(1); 
            distance_to_nearest_central_vein(i,j) = val; 

            oxygen(i,j) = o2_radial_profile( val , params ); 

        end
    end
    
    ii = ii+1; 
    if( ii > new_central_veins_count )
        done = true; 
        disp( 'max count' ); 
    end
    
%    if( max(max( distance_to_nearest_central_vein )) < 1.1 *  parameters.lobule_radius )
    if( max(max( oxygen )) < 1.05 *  parameters.max_oxygen )
        done = true; 
        disp( 'enough!' ); 
    end
    
end

% and now, a last round of correction: if two central veins are close
% together, replace with their centroid.

min_central_vein_spacing = 150; 

stop = false; 
% while( stop == false )
%     found = false; 
    
    
number_of_lobules 
size( central_vein_positions )
 
done = false; 
ii = 1; 
% for ii=1:number_of_lobules
while( done == false )    
    position = central_vein_positions(ii,:); 
    displacements = zeros( number_of_lobules, 2 ); 
    distances = zeros( 1 , number_of_lobules ); 
    for k=1:number_of_lobules
        displacements(k,:) = central_vein_positions(k,:) - position; 
        distances(k) = norm( displacements(k,:) , 2 ); 
    end

    distances(ii) = 9e9; 

    [val,ind] = min( distances );
    if( val < min_central_vein_spacing  ) 

        position_new = 0.5*( position + central_vein_positions(ind,:) ); 

        central_vein_positions(ii,:) = position_new ; 

        central_vein_positions(ind,:) = central_vein_positions(number_of_lobules,:); 

        central_vein_positions = central_vein_positions(1:number_of_lobules-1 , : ); 
        number_of_lobules = number_of_lobules - 1; 

        disp('aha!'); 
        
        for i=1:length(X)
            for j=1:length(Y)
                % find closest central vein 
                position = [X(i), Y(j)]; 
                displacements = zeros( number_of_lobules, 2 ); 
                distances = zeros( 1 , number_of_lobules ); 
                for k=1:number_of_lobules          
                    displacements(k,:) = central_vein_positions(k,:) - position; 
                    distances(k) = norm( displacements(k,:) , 2 ); 
                end

                [val,ind] = min( distances ); 
                nearest_index(i,j) = ind(1); 
                distance_to_nearest_central_vein(i,j) = val; 

                oxygen(i,j) = o2_radial_profile( val , params ); 

            end
        end
    
    end


    ii = ii+1;
    if( ii > number_of_lobules )
        done = true; 
    end

end
    
number_of_lobules 
size( central_vein_positions )    


return


