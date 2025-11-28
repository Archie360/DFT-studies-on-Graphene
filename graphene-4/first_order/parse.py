import matplotlib.pyplot as plt
import numpy as np
import scienceplots
import phonopy
import yaml
from phonopy.phonon.band_structure import get_band_qpoints_and_path_connections
import pickle

path = [[[0, 0, 0], [0.5, 0, 0], [0.33, 0.33, 0],[0, 0, 0]]]
labels = ["$\\Gamma$", "M", "K", "$\\Gamma$"]

qpoints, connections = get_band_qpoints_and_path_connections(path, npoints=201)
phonon = phonopy.load("phonopy_disp.yaml")
phonon.run_band_structure(qpoints, path_connections=connections,with_group_velocities=True, labels=labels)
d = phonon.get_band_structure_dict()

mesh = [50, 50, 1]
phonon.run_mesh(mesh,with_group_velocities=True,with_eigenvectors=True)
d1 = phonon.get_mesh_dict()


with open('band.pkl', 'wb') as f:
    pickle.dump(d, f)
    
with open('gv.pkl', 'wb') as f:
    pickle.dump(d1, f)