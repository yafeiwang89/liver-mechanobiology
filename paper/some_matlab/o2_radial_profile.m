function out = o2_radial_profile( r , parameters )
    out = parameters.min_oxygen * exp( parameters.oxygen_parameter * r ); 
    if( out > parameters.max_oxygen && parameters.cap == true )
        out = parameters.max_oxygen ; 
    end
return; 