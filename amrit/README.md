# GeoMx image analysis

## 1) repo setup

```
module load git
cd /arc/project/st-singha53/singha53/
git clone https://github.com/CompBio-Lab/geomx2rna.git
cd geomx2rna/
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
# load dependencies
module load gcc singularity

# 1. Launch a shell with the jupyter/datascience-notebook container on a Sockeye login node
singularity shell --home /scratch/st-singha53-1/singha53/geomx2rna/amrit/my_jupyter /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/jupyter-datascience.sif

# 2. Create or clone a conda environment
conda create --prefix /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/myenv python=3.7

# 3. Add the ipykernel module to the environment (required)
conda install -y ipykernel --prefix /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/myenv

# 4. Add all desired packages/modules to the environment
# - torch
conda install -y pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch --prefix /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/myenv

# 5. Convert the conda environment to an IPython Kernel and install it for your account, suitable for Jupyter Notebooks
conda run --prefix /arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/myenv python -m ipykernel install --user --name myenv

# 6. exit out of singularity image
exit
```

<st-alloc-1> = st-singha53-1

## install additional packages to environment (e.g. matplotlib)

```
conda activate myenv/
conda install -c conda-forge matplotlib
conda deactivate
```
  
## 3) run jupyter notebook

1. Create a job directory in /scratch for your personal Jupyter Notebooks job(s)
  
```
mkdir /scratch/st-singha53-1/singha53/geomx2rna/amrit/my_jupyter
cd /scratch/st-singha53-1/singha53/geomx2rna/amrit/my_jupyter
```

2. create jupyter-datascience.pbs
```
vi jupyter-datascience.pbs
```
  
3. hit 'i' then enter the following:
  
```
#PBS -l walltime=03:00:00,select=1:ncpus=12:ngpus=1:mem=64gb
#PBS -N geomx
#PBS -A st-singha53-1-gpu
#PBS -m abe
#PBS -M amrit.singh@ubc.ca
#PBS -e error.txt
#PBS -o output.txt

################################################################################

# set path variables
SCRATCH_PATH="/scratch/st-singha53-1/singha53/geomx2rna/amrit/my_jupyter"
PROJECT_PATH="/arc/project/st-singha53-1/singha53/geomx2rna/amrit/jupyter/"

# Change directory into the job dir
cd $PBS_O_WORKDIR

# Load software environment
module load gcc
module load singularity

# Set RANDFILE location to writeable dir
export RANDFILE=$TMPDIR/.rnd

# Generate a unique token (password) for Jupyter Notebooks
export SINGULARITYENV_JUPYTER_TOKEN=$(openssl rand -base64 15)

# Find a unique port for Jupyter Notebooks to listen on
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')

# Print connection details to file
cat > connection_${PBS_JOBID}.txt <<END
 
1. Create an SSH tunnel to Jupyter Notebooks from your local workstation using the following command:
 
ssh -N -L 8888:${HOSTNAME}:${PORT} ${USER}@sockeye.arc.ubc.ca
 
2. Point your web browser to http://localhost:8888
 
3. Login to Jupyter Notebooks using the following token (password):
 
${SINGULARITYENV_JUPYTER_TOKEN}
 
When done using Jupyter Notebooks, terminate the job by:
 
1. Quit or Logout of Jupyter Notebooks
2. Issue the following command on the login node (if you did Logout instead of Quit):
 
qdel ${PBS_JOBID}
 
END

# Execute jupyter within the jupyter/datascience-notebook container
singularity exec --nv \
  --home $SCRATCH_PATH \
  $PROJECT_PATH/jupyter-datascience.sif \
  jupyter notebook --no-browser --port=${PORT} --ip=0.0.0.0 --notebook-dir=$PBS_O_WORKDIR

```
  
2. Submit a job using the jupyter-datascience.pbs
```
qsub jupyter-datascience.pbs
```
 - this creates a connection file
  
  
3. open another terminal window (since the other one is logged into sockeye)
- copy ssh instructions from freshly producted connection file

example 
```
ssh -N -L 8888:se444:52896 singha53@sockeye.arc.ubc.ca
  
```

## copy data to scratch folder

- from local machine navigate to where the data is
```
scp -r geomx_data singha53@dtn.sockeye.arc.ubc.ca:/scratch/st-singha53-1/singha53/geomx2rna/amrit/my_jupyter/
```



References
1. https://confluence.it.ubc.ca/display/UARC/Jupyter+Notebooks+with+Singularity
