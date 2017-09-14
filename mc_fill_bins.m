function  [mc_bins] = mc_fill_bins(tau_mc_out, mc_bins, delta)

range = -1:delta:1;
for j = 1:(length(range)-1)
    if(tau_mc_out>= range(j) && tau_mc_out<range(j+1));
     mc_bins(j) = mc_bins(j)+1;   
    end
end
