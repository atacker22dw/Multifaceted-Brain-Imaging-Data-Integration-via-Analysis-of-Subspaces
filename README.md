# Multifaceted Brain Imaging Data Integration via Analysis of Subspaces
This repository hosts code corresponding to the manuscript, *Multifaceted Brain Imaging Data Integration via Analysis of Subspaces*.  This manuscript is currently under revision for the *Integrating and Analyzing Complex High-Dimensional Data in Social and Behavioral Sciences Research* special edition of *Psychometrika*, and the preprint can be found at [arXiv](https://arxiv.org/abs/2408.16791).   

The main branch consists of five subfolders -- `Preprocessing`, `DIVAS2021-main`, `Postprocessing`, `Principal Angle Analysis Validation`, and `Figures`.  The `Figures` subfolder just contains a .png file for every figure used in the associated manuscript[^1].  The `Preprocessing` subfolder includes four files necessary to prepare the HCP-YA data for submission to DIVAS.  These preprocessing steps are described in detail in Section 2 of the linked manuscript.  `impute_include_preprocess.m` is the wrapper function for this step of the analysis and is run on MATLAB2021b.  

The `DIVAS2021-main` branch is a local copy of the Data Integration via Analysis of Subspaces repository found [here](https://github.com/jbprothero/DIVAS2021).  Note, DIVAS will require an installation of a convex optimization solver, [CVX](http://cvxr.com/cvx/).  SeDuMi or SDPT3 solvers are reccomended for precise replication of our results.  The data integration routine accomplished via this `DIVAS2021-main` folder is described in Section 3.1 of the aforementioned paper.  

`Postprocessing` contains four files and two subfolders.  `decomp.m` computes the variational decomposition referrenced in Sections 3.3 and 4.1; `invert_vectorize.m` is used to produce Figures 2 and 3 and calls `plot_brain.m` which subsequently makes use of the `circularGraph` subfolder of functions.  The `DIVAS Jackstraw` folder contains a preprocessing script and a jackstraw routine script corresponding to the novel DIVAS Jackstraw method discussed in Section 3.2; and `trait_barplot.r` is necessary to produce Figure 4.  

Finally, the `Principal Angle Analysis Validation` folder contains the `PAA.m` file necessary to compute the Principal Angle Analysis discussed in Sections 3.4 and 4.3.  `PAA.m` will call `mPrinAngles.m`.  

The data used in this study (HCP-YA) is freely and publicly available at [ConnectomeDB website](https://www.humanconnectome.org/study/hcp-young-adult/data-releases). 


[^1]: also two figures -- `circ2.png` and `prothero_decomp.png` -- that are not included in the manuscript but commonly used in presenting the material.  `prothero_decomp.png` is actually Figure 1 from [DIVAS](https://link.springer.com/article/10.1007/s11749-024-00923-z) upon which I am coauthor.  
