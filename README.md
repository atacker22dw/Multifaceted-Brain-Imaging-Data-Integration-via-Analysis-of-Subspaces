# Multifaceted Brain Imaging Data Integration via Analysis of Subspaces
This repository hosts code corresponding to the manuscript, *Multifaceted Brain Imaging Data Integration via Analysis of Subspaces*.  This manuscript is currently under revision for the *Integrating and Analyzing Complex High-Dimensional Data in Social and Behavioral Sciences Research* special edition of *Psychometrika*, and the preprint can be found at [arXiv](https://arxiv.org/abs/2408.16791).   

## Install/Setup

- The data used in this study (HCP-YA) is freely and publicly available at [ConnectomeDB website](https://www.humanconnectome.org/study/hcp-young-adult/data-releases).
- DIVAS will require an installation of a convex optimization solver, [CVX](http://cvxr.com/cvx/).
    - SeDuMi or SDPT3 solvers are reccomended for precise replication of our results.
- MATLAB 2021b is used to run all .m files and RStudio 1.4.1103 is used for all .r files.  


## Usage

The main branch consists of four subfolders -- `Preprocessing`, `DIVAS2021-main`, `Postprocessing`, and `Principal Angle Analysis Validation`.  

- Preprocessing  
    - `impute_include_preprocess.m` is the wrapper function for all preprocessing described in Section 2 of the linked manuscript.
    - `re_PCA_genetics.R` computes a PCA of the genetic SNP's data.  The output of this file will be `rePCA.mat` that is read into the wrapper function.
    - `fillMissingValuesWithRowMean.m` is a function that will be called within `impute_include_preprocess.m` to perform row-mean imputation on the cognition and substance use data blocks as described in Section 2.2.
    - `checking_number_overlap.r` is a file to confirm the number of genetically related subjects shared between the discovery data set and the validation data set.  It is not required to be run to reproduce our main results.
 
- DIVAS2021-main
    - This is a local copy of the Data Integration via Analysis of Subspaces repository found [here](https://github.com/atacker22dw/DIVAS2021), placed here to make this repository fully self-contained.
    - Necessary functions can be found in the `DJIVECode` subfolder.  `DJIVEMainJP()` is the wrapper function that calls `DJIVESignalExtractJP()`, `DJIVEJointStrucEstimateJPLoadInfo()`, and `DJIVEReconstructMJ()` corresponding to the three steps of DIVAS discussed in Section 3.1 of the aforementioned paper.
    - The outstruct of DIVAS is discussed in this [ReadMe](https://github.com/atacker22dw/DIVAS2021), but in particular ```out.matLoadings{1}('11') and out.matBlocks{}()``` are used extensively in the postprocessing. 

    
 

`Postprocessing` contains four files and two subfolders.  `decomp.m` computes the variational decomposition referrenced in Sections 3.3 and 4.1; `invert_vectorize.m` is used to produce Figures 2 and 3 and calls `plot_brain.m` which subsequently makes use of the `circularGraph` subfolder of functions.  The `DIVAS Jackstraw` folder contains a preprocessing script and a jackstraw routine script corresponding to the novel DIVAS Jackstraw method discussed in Section 3.2; and `trait_barplot.r` is necessary to produce Figure 4.  

Finally, the `Principal Angle Analysis Validation` folder contains the `PAA.m` file necessary to compute the Principal Angle Analysis discussed in Sections 3.4 and 4.3.  `PAA.m` will call `mPrinAngles.m`.  




