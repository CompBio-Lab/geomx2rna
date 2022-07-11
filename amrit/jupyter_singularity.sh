# pull singularity jupyter notebook
mkdir /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/
module load gcc
module load singularity
cd /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/
singularity pull --name jupyter-datascience.sif docker://jupyter/datascience-notebook

