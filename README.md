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
    - Within the wrapper function, 
  ```
    out = DJIVEMainJP(datablock, paramstruct) ;
    %comment out for cluster
    %DJIVEAngleDiagnosticJP(datablock, fin_dat, out, 556, "FC,SC,Cog")
  ```
  `out` will include all outstruct components listed in the Data Integration via Analysis of Subspaces repository found [here](https://github.com/jbprothero/DIVAS2021).  `DJIVEAngleDiagnosticsJP` is commented out for ease of execution in a computing cluster.  This function creates the diagnostic plots seen in Figures 1, 5, 6 of the manuscript and can be run locally. 
 

The `DIVAS2021-main` branch is a local copy of the Data Integration via Analysis of Subspaces repository found [here](https://github.com/jbprothero/DIVAS2021).  Note, DIVAS will require an installation of a convex optimization solver, [CVX](http://cvxr.com/cvx/).  SeDuMi or SDPT3 solvers are reccomended for precise replication of our results.  The data integration routine accomplished via this `DIVAS2021-main` folder is described in Section 3.1 of the aforementioned paper.  

`Postprocessing` contains four files and two subfolders.  `decomp.m` computes the variational decomposition referrenced in Sections 3.3 and 4.1; `invert_vectorize.m` is used to produce Figures 2 and 3 and calls `plot_brain.m` which subsequently makes use of the `circularGraph` subfolder of functions.  The `DIVAS Jackstraw` folder contains a preprocessing script and a jackstraw routine script corresponding to the novel DIVAS Jackstraw method discussed in Section 3.2; and `trait_barplot.r` is necessary to produce Figure 4.  

Finally, the `Principal Angle Analysis Validation` folder contains the `PAA.m` file necessary to compute the Principal Angle Analysis discussed in Sections 3.4 and 4.3.  `PAA.m` will call `mPrinAngles.m`.  




