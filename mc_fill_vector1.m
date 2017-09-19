% This function fills in a vector all the rays informations

function mc_fill_vector1(z,t,zout,tout,path, energy)

global mc_vector1
mc_vector1.zin = [mc_vector1.zin; z];
mc_vector1.zout = [mc_vector1.zout; zout];
mc_vector1.tauin = [mc_vector1.tauin; t];
mc_vector1.tauout = [mc_vector1.tauout; tout];
mc_vector1.path = [mc_vector1.path path];
mc_vector1.energy = [mc_vector1.energy energy];
