set_liver_parameters(); 

[X,Y,central_vein_positions,oxygen,nearest_index,distance_to_nearest_central_vein,random_seed] = create_liver_and_oxygen( parameters ); 

tissue_plots(); 


figure(6)
discretize_liver();


figure(5)
print -dpng -noui -opengl -r900 liver_o2_voronoi.png

figure(6)
print -dpng -noui -opengl -r900 discrete_liver_tissue.png

save_biofvm_liver();



