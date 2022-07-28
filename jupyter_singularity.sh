# pull singularity jupyter notebook
module load gcc
module load singularity
cd /arc/project/$ALLOC/$USER/geomx2rna/
singularity pull --name jupyter-datascience.sif docker://jupyter/datascience-notebook