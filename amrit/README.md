# GeoMx image analysis

## 1) repo setup

```
module load git
cd /arc/project/st-singha53/singha53/
git clone https://github.com/CompBio-Lab/geomx2rna.git

```

## 2) jupyter notebook singularity image setup
1. move to project location
```
cd /arc/project/st-singha53-1/singha53/geomx2rna/amrit/
```

2. pull jupyter notebook by running jupyter_singularity.sh

```
sh jupyter_singularity.sh
```

3. add packages to singularity image

```
sh install_torch.sh
```

<st-alloc-1> = st-singha53-1

  
## 3) run jupyter notebook

1. Create a job directory in /scratch for your personal Jupyter Notebooks job(s)
  
```
mkdir /scratch/st-singha53-1/singha53/geomx2rna
cd /scratch/st-singha53-1/singha53/geomx2rna
```

1. Submit a job using the jupyter-datascience.pbs
```
qsub jupyter-datascience.pbs
```
 

References
1. https://confluence.it.ubc.ca/display/UARC/Jupyter+Notebooks+with+Singularity
