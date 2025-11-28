rm *.hdf5
phonopy-load -f scf_*.out
phonopy-load --config band.conf
python parse.py
