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
sh install_packages.sh
```

Contents of file
```
module load gcc singularity
singularity shell --home /scratch/st-singha53-1/singha53/my_jupyter /arc/project/st-singha53-1/jupyter/jupyter-datascience.sif

conda create --prefix /arc/project/st-singha53-1/jupyter/MyNewEnvironment

conda install -y ipykernel --prefix /arc/project/st-singha53-1/jupyter/MyNewEnvironment

conda install -y numpy --prefix /arc/project/st-singha53-1/jupyter/MyNewEnvironment

conda run --prefix /arc/project/st-singha53-1/jupyter/MyNewEnvironment python -m ipykernel install --user --name MyNewEnvironment

```

<st-alloc-1> = st-singha53-1


References
1. https://confluence.it.ubc.ca/display/UARC/Jupyter+Notebooks+with+Singularity
