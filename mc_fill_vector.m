% This function fills in a vector all the rays informations

function mc_fill_vector(z,t,zout,tout,path, energy)

global mc_vector
mc_vector.zin = [mc_vector.zin; z];
mc_vector.zout = [mc_vector.zout; zout];
mc_vector.tauin = [mc_vector.tauin; t];
mc_vector.tauout = [mc_vector.tauout; tout];
mc_vector.path = [mc_vector.path path];
mc_vector.energy = [mc_vector.energy energy];