#!/bin/bash

# load dependencies
module load gcc singularity

# 1. Launch a shell with the jupyter/datascience-notebook container on a Sockeye login node
singularity shell --home /scratch/st-singha53-1/singha53/geomx2rna/amrit/my_jupyter /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/jupyter-datascience.sif

# 2. Create or clone a conda environment
conda create --prefix /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/myenv

# 3. Add the ipykernel module to the environment (required)
conda install -y ipykernel --prefix /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/myenv

# 4. Add all desired packages/modules to the environment
# - torch
conda install -y pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch --prefix /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/myenv

# 5. Convert the conda environment to an IPython Kernel and install it for your account, suitable for Jupyter Notebooks
conda run --prefix /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/myenv python -m ipykernel install --user --name myenv
