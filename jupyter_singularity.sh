# pull singularity jupyter notebook
mkdir /arc/project/st-allocation-code/$USER/geomx2rna/
module load gcc
module load singularity
cd /arc/project/st-allocation-code/$USER/geomx2rna/
singularity pull --name jupyter-datascience.sif docker://jupyter/datascience-notebook