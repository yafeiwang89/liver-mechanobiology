
function [X,Y,central_vein_positions,oxygen,nearest_index,distance_to_nearest_central_vein,random_seed] = create_liver_and_oxygen( parameters )

rng( 'shuffle' ); 

rng(486688478); % fixed random seed to reproduce the published simulation study 

% rng(486273772) % good for min_dist = 1.3 * ...

random_seed = rng; 

domain_edge_length = parameters.domain_edge_length; 
dx = parameters.dx; 

X = -domain_edge_length/2 + dx/2 : dx : domain_edge_length/2 -dx/2; 
Y = X; 
Z = 0; 

% oxygen_parameter = log( parameters.max_oxygen / parameters.min_oxygen) / parameters.lobule_radius;

% set up parameters and tweaks to generate a large section of liver tissue,
% without central veins too close together. 

domain_area = domain_edge_length^2; 

radius_temp = parameters.lobule_radius; 
typical_lobular_area = pi*radius_temp^2;

number_of_lobules = ceil( domain_area / typical_lobular_area );
number_of_lobules = ceil( number_of_lobules * 1.2 ); 

central_vein_positions = zeros(2,number_of_lobules)'; 

% place the central veins 

for i=1:number_of_lobules
    disp( sprintf( '%u of %u' , i , number_of_lobules ) ); 
    central_vein_positions(i,1)= -domain_edge_length/2 + domain_edge_length*random('unif',0,1); 
    central_vein_positions(i,2)= -domain_edge_length/2 + domain_edge_length*random('unif',0,1);    
    
    reject = true; 
    if( i == 1 )
        reject = false;
    end
    count = 0;
    max_count =  1000; 
    while( reject )   
        reject = false; % new  
        position = central_vein_positions(i,:); 
        displacements = zeros( i-1, 2 ); 
        distances = zeros( 1 , i-1 ); 
        for k=1:i-1
            displacements(k,:) = central_vein_positions(k,:) - position; 
            distances(k) = norm( displacements(k,:) , 2 ); 
        end
        [val,ind] = min( distances );
        if( val < parameters.min_central_vein_spacing && count < max_count ) 
            reject = true; 
            central_vein_positions(i,1)= -domain_edge_length/2 + domain_edge_length*random('unif',0,1); 
            central_vein_positions(i,2)= -domain_edge_length/2 + domain_edge_length*random('unif',0,1);    
            count = count+1; 
        end
%         if( val > parameters.min_central_vein_spacing || count > max_count ) 
%             reject = false; 
%         else
%             central_vein_positions(i,1)= -domain_edge_length/2 + domain_edge_length*random('unif',0,1); 
%             central_vein_positions(i,2)= -domain_edge_length/2 + domain_edge_length*random('unif',0,1);    
%             count = count+1; 
%         end 
    end
end

% initialize the oxygen profile 

oxygen = zeros( length(X) , length(Y) ); 
nearest_index = oxygen; 
distance_to_nearest_central_vein = oxygen; 

% params.min_oxygen = parameters.min_oxygen; 
% params.oxygen_parameter = oxygen_parameter; 
% params.max_oxygen = parameters.max_oxygen; 
% params.cap = false; true; 

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
        
        oxygen(i,j) = o2_radial_profile( val , parameters ); % params ); 
        
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

            oxygen(i,j) = o2_radial_profile( val , parameters ); % params ); 

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

                oxygen(i,j) = o2_radial_profile( val , parameters ); %  params ); 

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


