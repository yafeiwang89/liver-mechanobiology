function out = radial_flow_profile( r , parameters )
    out = parameters.flow_a * exp( -parameters.flow_b * r ) ; 
return; 