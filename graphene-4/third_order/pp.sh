phono3py --cf3 scf-job/*.out
phono3py --fc-symmetry
phono3py --mesh="20 20 1" --fc3 --fc2 --br --isotope --full-pp 
phono3py-kdeplot --cmap="OrRd" --ymax=300 --xmax=50 kappa-m*.hdf5