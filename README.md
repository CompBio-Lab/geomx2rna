### Can Tissue Images Predict Kidney Disease and Infer Spatial Gene Expression?

P. Thangarajah*, G. Hothi*, K. Korolek*, A. Singh  

### Table of contents

- [Abstract](#abstract)
  - [Background](#background)
  - [Hypothesis](#hypothesis)
  - [Methods](#methods)
  - [Conclusion](#conclusion)
- [Quick start options](#quick-start-options)
  - [repo setup on local machine](#repo-setup-on-local-machine)
  - [repo setup on HPC (UBC ARC Sockeye)](#repo-setup-on-hpc-ubc-arc-sockeye)
- [Jupyter notebook singularity image setup on HPC (UBC ARC Sockeye)](#jupyter-notebook-singularity-image-setup-on-hpc-ubc-arc-sockeye)
- [install additional packages to environment (e.g. matplotlib)](#install-additional-packages-to-environment-eg-matplotlib)
- [Run jupyter notebook](#run-jupyter-notebook)
- [Copying data](#copying-data)
- [Bugs and feature requests](#bugs-and-feature-requests)
- [Contributing](#contributing)
- [Copyright and license](#copyright-and-license)

## Abstract
### Background
Digitized Hematoxylin & Eosin (H&E) images are used to predict tumour genotypes, mutations, gene expression and clinical phenotypes. However, H&E staining can only identify larger structures (e.g., cell nuclei) and preparation and digitization of histological samples can lead to errors such as colour variations, resulting in artifacts and inconsistencies in histological image analysis systems. To combat this, recent technology such as the GeoMx Digital Spatial Profiler (DSP), allows the staining of up to four morphological markers concurrently followed by the measurement of up to 18,000 genes in select regions of interest (ROIs). The GeoMx DSP does this by imaging or staining whole tissue sections for RNA or protein, followed by the counting of gene expression levels using an nCounter analysis system. However, GeoMx DSP requires ROIs to be selected manually by the user, resulting in difficulties with discriminating disease conditions and the inability to spatially resolve gene expression for entire tissue slides. To resolve these difficulties, we aim to train convolutional neural networks (CNN), a form of deep learning, with tissue imaging data to predict diabetic kidney disease (DKD) and spatial gene expression data from the GeoMx DSP Spatial Organ Atlas (i.e., a web base that delivers whole transcriptome data sets of organ tissues with spatial context) by Nanostring Technologies.   

### Hypothesis
- (a) CNNs can be used to discriminate DKD from healthy kidney tissues 
- (b) Imaging data can be used to predict spatial gene expression data.  

### Methods
Whole Slide Images of 3 diabetic and 3 healthy patients’ kidney samples were obtained from the Nanostring database. Each image was split into thousands of smaller images, each of size 256x256 pixels (patches). These patches were then transformed into 1024-dimenstional vectors using a pre-existing computer vision model called ResNet50 (a pre-trained model that can classify images into 1000 categories). After the patches were created, the data and corresponding labels were split into training, test, and validation sets. The ResNet50 will be fine-tuned to our problem by further training an additional neural network layer to predict DKD from healthy controls (ResNet50-binary). The ResNet-binary model will be applied to the test data and evaluated using the F1 score, a measurement of a model's accuracy that focuses on precision (fraction of correctly classified positive samples among all predicted positive samples) and recall (ratio between correctly classified positive samples and the combination of correctly classified positive samples with incorrectly classified negative samples). To predict spatial gene expression data, we will use images of the 231 pre-selected ROIs and their corresponding whole genome expression. Similar to the ResNet-binary model development, we will fine-tune the ResNet50 model by adding an additional layer to predict gene expression (ResNet50-continuous). The ResNet-continuous model will be applied to the test data and evaluated using the mean squared error.  

   

Results: We expect our trained CNN to discriminate between healthy kidney and DKD tissue patches, as structural changes like thickening of tubular basement membranes and interstitial widening can be visibly observed in the DKD samples. Studies using H&E images have successfully predicted gene expression; therefore, we expect similar outcomes using higher resolution images from GeoMx. For the prediction of spatial gene expression data, we expect a higher correlation between cell-specific genes than other genes as imaging slides are based on morphology markers (tissue sections are stained with dyes which highlight different structures). For example, we expect our models would better predict the expression of CD45 compared to other markers if tissue imaging slides were stained for CD45.   

### Conclusion
Open-source deep learning models effectively classify DKD from healthy tissue patches and predict spatial gene expression data. The modified models could be used alongside the GeoMx DSP to help pathologists make clinical diagnoses and prognostics.   

## Quick start options
* assume git is install, check using:

```
git --version
```

### repo setup on local machine

```
git clone https://github.com/CompBio-Lab/geomx2rna.git
cd geomx2rna/
```

### repo setup on HPC (UBC ARC Sockeye)
* clone repo to project and scratch folders
```
module load git
mkdir /scratch/st-allocation-code/$USER
cd /arc/project/st-allocation-code/$USER/
git clone https://github.com/CompBio-Lab/geomx2rna.git
cd geomx2rna/

mkdir /scratch/st-allocation-code/$USER
cd /scratch/st-allocation-code/$USER
git clone https://github.com/CompBio-Lab/geomx2rna.git
cd geomx2rna/
```

* st-allocation-code: Sockeye allocation code
* $USER: UBC Campus wide login

## Jupyter notebook singularity image setup on HPC (UBC ARC Sockeye)
* st-allocation-code: Sockeye allocation code
* $USER: UBC Campus wide login


Convert the following set of steps into reproducible workflow:
1. move to project location
```
cd /arc/project/st-allocation-code/$USER/geomx2rna/
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
singularity shell --home /scratch/st-allocation-code/$USER/geomx2rna/ /arc/project/st-allocation-code/$USER/geomx2rna/jupyter-datascience.sif

# 2. Create or clone a conda environment
conda create --prefix /arc/project/st-allocation-code/$USER/geomx2rna/myenv python=3.7

# 3. Add the ipykernel module to the environment (required)
conda install -y ipykernel --prefix /arc/project/st-allocation-code/$USER/geomx2rna/myenv

# 4. Add all desired packages/modules to the environment
# - torch
conda install -y pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch --prefix /arc/project/st-allocation-code/$USER/geomx2rna/myenv

# 5. Convert the conda environment to an IPython Kernel and install it for your account, suitable for Jupyter Notebooks
conda run --prefix /arc/project/st-allocation-code/$USER/geomx2rna/myenv python -m ipykernel install --user --name myenv

# 6. exit out of singularity image
exit
```

<st-alloc-1> = st-singha53-1

## install additional packages to environment (e.g. matplotlib)

```
cd /arc/project/st-allocation-code/$USER/geomx2rna/
source activate myenv/
conda install -c conda-forge matplotlib
conda install captum -c pytorch
conda deactivate
```

## Run jupyter notebook

1. Create a job directory in /scratch for your personal Jupyter Notebooks job(s)
  
```
mkdir /scratch/st-allocation-code/$USER/geomx2rna/
cd /scratch/st-allocation-code/$USER/geomx2rna/
```

2. create jupyter-datascience.pbs
```
vi jupyter-datascience.pbs
```
  
3. hit 'i' then enter the following:
  
```
#PBS -l walltime=03:00:00,select=1:ncpus=12:ngpus=1:mem=64gb
#PBS -N geomx
#PBS -A st-allocation-code-gpu
#PBS -m abe
#PBS -M your.email@ubc.ca
#PBS -e error.txt
#PBS -o output.txt

################################################################################

# set path variables
SCRATCH_PATH="/scratch/st-allocation-code/$USER/geomx2rna"
PROJECT_PATH="/arc/project/st-allocation-code/$USER/geomx2rna"
DATA="/scratch/st-allocation-code/datasets/geomx/dkd/geomx_pngs"

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
  --bind $DATA \
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
ssh -N -L 8888:${HOSTNAME}:${PORT} ${USER}@sockeye.arc.ubc.ca
```
    

## Copying data
* data can be found [here](http://nanostring-public-share.s3-website-us-west-2.amazonaws.com/GeoScriptHub/)

- from local machine navigate to where the data is
```
scp -r geomx_data cwl@dtn.sockeye.arc.ubc.ca:/scratch/st-allocation-code/$USER/geomx2rna/
```

## Bugs and feature requests

Have a bug or a feature request? Please add your request here: https://github.com/CompBio-Lab/geomx2rna/issues

## Contributing

Please feel free to make a pull request if you would like to modify anything.

## Copyright and license

Copyright 2021 CompBio-Lab Inc.

Code released under the [MIT license](https://github.com/CompBio-Lab/geomx2rna/blob/main/LICENSE).
