function out = o2_radial_profile( r , parameters )
    % out = parameters.min_oxygen * exp( parameters.oxygen_parameter * r ); 
    out = parameters.o2_c * exp( parameters.o2_param*( exp(parameters.flow_b*r)-1 ) ); 
    
    if( parameters.cap == true )
        if( out > parameters.max_oxygen  )
            out = parameters.max_oxygen ; 
        end
        if( out < parameters.min_oxygen  )
            out = parameters.min_oxygen ; 
        end
        
    end
    
return; 