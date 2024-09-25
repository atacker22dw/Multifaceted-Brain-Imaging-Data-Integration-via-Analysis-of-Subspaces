# Multifaceted Brain Imaging Data Integration via Analysis of Subspaces
This repository hosts code corresponding to the Manuscript, *Multifaceted Brain Imaging Data Integration via Analysis of Subspaces*.  This manuscript is currently under revision for the *Integrating and Analyzing Complex High-Dimensional Data in Social and Behavioral Sciences Research* special edition of *Psychometrika*, and the preprint can be found at [arXiv](https://arxiv.org/abs/2408.16791).   

The main branch consists of four subfolders -- `Preprocessing`, `DIVAS2021-main`, `Postprocessing`, and `Principal Angle Analysis Validation`.  The `Preprocessing` subfolder includes four files necessary to prepare the HCP-YA data for submission to DIVAS.  These preprocessing steps are described in detail in Section 2 of the linked manuscript.  `impute_include_preprocess.m` is the wrapper function for this step of the analysis and is run on MATLAB2021b.  

The `DIVAS2021-main` branch is a local copy of the Data Integration via Analysis of Subspaces repository found 
