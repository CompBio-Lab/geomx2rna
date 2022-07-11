# GeoMx image analysis

## repo setup


## jupyter notebook setup
1. move to project location
```
cd /arc/project/st-singha53-1/singha53/geomx2rna/amrit/
```

2. pull jupyter notebook by running jupyter_singularity.sh

```
sh jupyter_singularity.sh
```

Contents of file
```
mkdir /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/
module load gcc
module load singularity
cd /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/
singularity pull --name jupyter-datascience.sif docker://jupyter/datascience-notebook
```

3. add packages to singularity image


```
sh install_torch.sh
```

Contents of file
```
#!/bin/bash

# load dependencies
module load gcc singularity

PROJECT_PATH="/arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/"

# 1. Launch a shell with the jupyter/datascience-notebook container on a Sockeye login node
singularity shell --home /scratch/st-singha53-1/singha53/geomx2rna/amrit/my_jupyter $PROJECT_PATH/jupyter-datascience.sif

# 2. Create or clone a conda environment
conda create --prefix $PROJECT_PATH/myenv

# 3. Add the ipykernel module to the environment (required)
conda install -y ipykernel --prefix $PROJECT_PATH/myenv

# 4. Add all desired packages/modules to the environment
# - torch
conda install -y pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch --prefix $PROJECT_PATH/myenv

# 5. Convert the conda environment to an IPython Kernel and install it for your account, suitable for Jupyter Notebooks
conda run --prefix $PROJECT_PATH/myenv python -m ipykernel install --user --name myenv

```

<st-alloc-1> = st-singha53-1


References
1. https://confluence.it.ubc.ca/display/UARC/Jupyter+Notebooks+with+Singularity
