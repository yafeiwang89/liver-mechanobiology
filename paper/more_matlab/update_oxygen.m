
function oxygen = update_oxygen( X,Y,central_vein_positions,nearest_index, distance_to_nearest_central_vein,parameters )

% initialize the oxygen profile 

oxygen = zeros( length(X) , length(Y) ); 

for i=1:length(X)
    for j=1:length(Y)
        
        oxygen(i,j) = o2_radial_profile( distance_to_nearest_central_vein(i,j) , parameters ); % params ); 
        
    end
end

return


