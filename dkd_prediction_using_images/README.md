# Predicting DKD from normals using digitized tissue images

### Table of Contents
- [Predicting DKD from normals using digitized tissue images](#predicting-dkd-from-normals-using-digitized-tissue-images)
    - [Table of Contents](#table-of-contents)
  - [Jupyter notebook setup on HPC (UBC ARC Sockeye)](#jupyter-notebook-setup-on-hpc-ubc-arc-sockeye)
  - [Data](#data)
    - [Copy data from local machine to HPC Sockeye](#copy-data-from-local-machine-to-hpc-sockeye)
    - [Unpack data](#unpack-data)
  - [Fetch singularity file and install required packages](#fetch-singularity-file-and-install-required-packages)
  - [Download Pre-trained models](#download-pre-trained-models)
  - [Run jupyter notebook](#run-jupyter-notebook)
  - [Using CLAM:](#using-clam)
  - [Recorded Errors:](#recorded-errors)
- [TOAD](#toad)
- [HE2RNA](#he2rna)

## Jupyter notebook setup on HPC (UBC ARC Sockeye)
- based on instructions [here](https://github.com/CompBio-Lab/geomx2rna/blob/main/README.md)


## Data
### Copy data from local machine to HPC Sockeye
- copy  to HPC by copying ROI images from ROI reports to sockeye

```
scp -r geomx_pngs cwl@dtn.sockeye.arc.ubc.ca:/scratch/st-allocation-code/datasets/geomx/dkd/
```

### Unpack data
```
unzip geomx_pngs/
```

## Fetch singularity file and install required packages
* see instructions [here](https://github.com/CompBio-Lab/geomx2rna/blob/main/README.md)

## Download Pre-trained models

* move to scratch location

```
cd /scratch/st-allocation-code/$USER/geomx2rna
```

* download AlexNet

```
wget -c https://download.pytorch.org/models/alexnet-owt-4df8aa71.pth
```
* other models [https://stackoverflow.com/questions/52628270/is-there-any-way-i-can-download-the-pre-trained-models-available-in-pytorch-to-a]


* download ImageNet labels
```
!wget -P / https://s3.amazonaws.com/deep-learning-models/image-models/imagenet_class_index.json
```

## Run jupyter notebook
* see instructions [here](https://github.com/CompBio-Lab/geomx2rna/blob/main/README.md)

```
qsub jupyter-datascience.pbs
```

* open geomx_dkd_prediction.ipynb to run analysis

## Using CLAM:  

* For SVS files, original repository from mahmood lab can be used : https://github.com/mahmoodlab/CLAM

* for TIFF Files, repository with adjusted code should be used: https://github.com/pcicales/CLAM.git

## Recorded Errors:
* Can't parse 'pt'. Sequence item with index 0 has a wrong type. Can be fixed by reinstalling opencv 4.5.1.48. For more information : https://stackoverflow.com/questions/67837617/cant-parse-pt-sequence-item-with-index-0-has-a-wrong-type-pointpolygon-er


# TOAD
https://github.com/mahmoodlab/TOAD
[paper link](https://login.microsoftonline.com/2fff08c9-91d4-4fc8-bbdd-dd59b7414ddb/oauth2/authorize?client_id=00000003-0000-0ff1-ce00-000000000000&response_mode=form_post&protectedtoken=true&response_type=code%20id_token&resource=00000003-0000-0ff1-ce00-000000000000&scope=openid&nonce=D2A659D2F6774DA885400C9C1E740EDD547F3BD5C23A6821-6B395FE89396342270BF2947F56ED60058E259469D70527623930C50242B154A&redirect_uri=https%3A%2F%2Fubcca.sharepoint.com%2F_forms%2Fdefault.aspx&state=OD0w&claims=%7B%22id_token%22%3A%7B%22xms_cc%22%3A%7B%22values%22%3A%5B%22CP1%22%5D%7D%7D%7D&wsucxt=1&cobrandid=11bd8083-87e0-41b5-bb78-0bc43c8a8e8a&client-request-id=769949a0-105d-2000-0915-e17895599a37)

# HE2RNA
https://login.microsoftonline.com/2fff08c9-91d4-4fc8-bbdd-dd59b7414ddb/oauth2/authorize?client_id=00000003-0000-0ff1-ce00-000000000000&response_mode=form_post&protectedtoken=true&response_type=code%20id_token&resource=00000003-0000-0ff1-ce00-000000000000&scope=openid&nonce=D2A659D2F6774DA885400C9C1E740EDD547F3BD5C23A6821-6B395FE89396342270BF2947F56ED60058E259469D70527623930C50242B154A&redirect_uri=https%3A%2F%2Fubcca.sharepoint.com%2F_forms%2Fdefault.aspx&state=OD0w&claims=%7B%22id_token%22%3A%7B%22xms_cc%22%3A%7B%22values%22%3A%5B%22CP1%22%5D%7D%7D%7D&wsucxt=1&cobrandid=11bd8083-87e0-41b5-bb78-0bc43c8a8e8a&client-request-id=769949a0-105d-2000-0915-e17895599a37

