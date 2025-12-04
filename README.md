# Phonon properties of monolayer Graphene under substrate strain
This repository contains Density Functional Theory (DFT) and lattice-dynamics workflows for studying phonon properties of monolayer graphene under different substrate-induced strains. Calculations use Quantum ESPRESSO for electronic/force calculations and Phonopy / Phono3py for harmonic and anharmonic phonon analysis. Strain cases are arranged in folders named `graphene-X` where `X` denotes the applied substrate strain (e.g. `graphene--4`, `graphene-0`, `graphene-4`).

## Scientific goal
Quantify how small biaxial/uniaxial substrate strains modify:
- phonon dispersion (frequencies and band topology),
- group velocities and eigenvectors,
- phonon lifetimes (scattering rates) and mode-resolved thermal conductivity (via third-order/Phono3py outputs).

These observables provide mechanistic insight into strain–phonon coupling and thermal transport tuning in 2D graphene.

## Repository layout (selected)
- Notebooks and visualization:
  - [Graphene/first.ipynb](Graphene/first.ipynb) — harmonic phonon plots across strains
  - [Graphene/first copy.ipynb](Graphene/first%20copy.ipynb) — alternative plotting script
  - [Graphene/third.ipynb](Graphene/third.ipynb) — third-order / kappa / lifetimes analysis
  - [Graphene/mono-graphene/plot.ipynb](Graphene/mono-graphene/plot.ipynb) — single-layer band plots
- Strain cases:
  - [Graphene/graphene--4/first_order/](Graphene/graphene--4/first_order/) — harmonic outputs and parsing helper
  - [Graphene/graphene--2/first_order/](Graphene/graphene--2/first_order/)
  - [Graphene/graphene-0/first_order/](Graphene/graphene-0/first_order/)
  - [Graphene/graphene-2/first_order/](Graphene/graphene-2/first_order/)
  - [Graphene/graphene-4/first_order/](Graphene/graphene-4/first_order/)
- Third-order / thermal conductivity outputs:
  - e.g. [Graphene/graphene--4/third_order/kappa-m20201.hdf5](Graphene/graphene--4/third_order/kappa-m20201.hdf5)
  - e.g. [Graphene/graphene-2/third_order/kappa-m20201.hdf5](Graphene/graphene-2/third_order/kappa-m20201.hdf5)
- Pseudopotentials:
  - [Graphene/pseudo/C.upf](Graphene/pseudo/C.upf)
  - [Graphene/pseudo/C.pbe-n-kjpaw_psl.1.0.0.UPF](Graphene/pseudo/C.pbe-n-kjpaw_psl.1.0.0.UPF)
- Example DFT inputs (mono-layer):
  - [Graphene/mono-graphene/band.in](Graphene/mono-graphene/band.in)
  - [Graphene/mono-graphene/scf.in](Graphene/mono-graphene/scf.in)

## Key scripts / parsing utilities
Each `first_order` folder contains a small parsing script that builds serialised Python objects for plotting:
- parse scripts: [`graphene--4/first_order/parse.py`](Graphene/graphene--4/first_order/parse.py), [`graphene--2/first_order/parse.py`](Graphene/graphene--2/first_order/parse.py), [`graphene-0/first_order/parse.py`](Graphene/graphene-0/first_order/parse.py), [`graphene-2/first_order/parse.py`](Graphene/graphene-2/first_order/parse.py), [`graphene-4/first_order/parse.py`](Graphene/graphene-4/first_order/parse.py)
  - These scripts create `band.pkl` and `gv.pkl` by calling Phonopy API (`phonopy.load(...)`, `phonon.run_band_structure(...)`, `phonon.run_mesh(...)`) and then writing with pickle:
    - see e.g. [`phonon`](Graphene/graphene--4/first_order/parse.py) object and serialized dictionaries [`d`, `d1`] in the script.
  - Output files:
    - `band.pkl` — harmonic band-structure dictionary (used by notebooks)
    - `gv.pkl` — mesh dictionary with group velocities & eigenvectors

Examples:
- harmonic parse: [Graphene/graphene--4/first_order/parse.py](Graphene/graphene--4/first_order/parse.py)
- third-order analysis notebooks read HDF5: [Graphene/graphene-2/third_order/phonon.ipynb](Graphene/graphene-2/third_order/phonon.ipynb)

## Workflow (reproducible recipe)
1. DFT stage (Quantum ESPRESSO)
   - Run SCF and supercell force calculations using inputs in each case (see `scf.in`, `supercell.in` in each `graphene-X/`).
   - Pseudopotentials: [Graphene/pseudo/](Graphene/pseudo/)
2. Generate harmonic force constants with Phonopy
   - Place `FORCE_SETS` / `FORCE_CONSTANTS` in `first_order/`.
   - Run Phonopy band & mesh steps (helper scripts `pp.sh`, `run.sh`, `pre.sh` in the directory).
3. Parse harmonic results
   - From each `first_order/` folder run:
     - python parse.py
     - This produces `band.pkl` and `gv.pkl` (see [`parse.py`](Graphene/graphene--4/first_order/parse.py) for implementation).
4. Third-order / thermal conductivity
   - Use Phono3py to compute `fc2.hdf5`, `fc3.hdf5` and then produce `kappa-*.hdf5` in `third_order/`.
   - Notebooks read `kappa-m20201.hdf5` directly (see [Graphene/third.ipynb](Graphene/third.ipynb) and [Graphene/graphene-2/third_order/phonon.ipynb](Graphene/graphene-2/third_order/phonon.ipynb)).
5. Visualization & analysis
   - Use the notebooks: [Graphene/first.ipynb](Graphene/first.ipynb), [Graphene/first copy.ipynb](Graphene/first%20copy.ipynb), [Graphene/third.ipynb](Graphene/third.ipynb).
   - Common plots: phonon dispersions, group velocity vs q, mode lifetimes (tau = 1/(2*pi*gamma)), mode-resolved kappa contributions.

## Data & outputs (what to inspect)
- Harmonic:
  - [Graphene/graphene--4/first_order/band.pkl](Graphene/graphene--4/first_order/band.pkl)
  - [Graphene/graphene--4/first_order/gv.pkl](Graphene/graphene--4/first_order/gv.pkl)
- Anharmonic / thermal:
  - [Graphene/graphene--4/third_order/kappa-m20201.hdf5](Graphene/graphene--4/third_order/kappa-m20201.hdf5)
  - [Graphene/graphene-2/third_order/kappa-m20201.hdf5](Graphene/graphene-2/third_order/kappa-m20201.hdf5)
- Figures (examples):
  - [Graphene/dispersion.png](Graphene/dispersion.png)
  - [Graphene/group_vel.png](Graphene/group_vel.png)
  - [Graphene/lifetimes.png](Graphene/lifetimes.png)

## Note
- Use consistent q-point meshes across strain cases when comparing group velocities or lifetimes to avoid sampling artifacts (mesh size is set in each `first_order/` parse: `mesh = [50, 50, 1]`).
- When converting scattering rates gamma → lifetime use: lifetime = 1 / (2 * 2 * pi * gamma) (see notebooks).
- Keep pseudopotential and energy cutoff consistent across strains to isolate strain effects .
- Be mindful of Brillouin-zone path and label consistency (Gamma, M, K, Gamma) — path generation is via Phonopy API in parse scripts.

## Dependencies
- Quantum ESPRESSO (DFT)
- Python 3.8+ with:
  - numpy, matplotlib, h5py, yaml, pickle
  - phonopy, phono3py
  - scienceplots (optional, used in plotting notebooks)
- Jupyter / JupyterLab to run the notebooks


