save X.mat X -v4
save Y.mat Y -v4
save oxygen.mat oxygen -v4 

n1 = length( central_vein_positions ); 
n2 = length( portal_triad_positions ); 
n3 = length( parenchyme_positions ); 

cells = zeros( n1+n2+n3 , 5 ); 

cells(1:n1 , 1:2 ) = central_vein_positions ; 
ind = ones( n1 , 1 );
cells(1:n1 , 4 ) = parameters.central_vein_radius * ind ; 
cells(1:n1 , 5 ) = 1*ind; 

cells(n1+1:n1+n2 , 1:2 ) = portal_triad_positions; 
ind = ones( n2 , 1 ); 
cells(n1+1:n1+n2 , 4 ) = parameters.portal_triad_radius * ind ; 
cells(n1+1:n1+n2 , 5 ) = 2*ind; 

cells(n1+n2+1:n1+n2+n3 , 1:2 ) = parenchyme_positions; 
ind = ones( n3 , 1 ); 
cells(n1+n2+1:n1+n2+n3 , 4 ) = parameters.parenchyme_radius * ind ; 
cells(n1+n2+1:n1+n2+n3 , 5 ) = 3*ind; 

n1+n2+n3 

save cells.mat cells -v4 
% print -dpng -noui -opengl -r600 discrete_liver_tissue.png
% print -dpng -noui -opengl -r900 discrete_liver_tissue.png

!zip liver_tissue.zip X.mat Y.mat oxygen.mat cells.mat 
