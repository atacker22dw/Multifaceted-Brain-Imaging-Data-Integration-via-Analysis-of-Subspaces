clear all;
close all;
%this is needed for the cluster
cvx_setup
%note we have two different versions of divas.  specify here
addpath('DIVAS2021-main')
addpath('DIVAS2021-main/DJIVECode')

%load data
load desikan_fc_all.mat
%SC; using the 87 by 87 subcortical desikan SC version
load('HCP_subcortical_CMData_desikan (1).mat')
%trait data
load('HCP_Covariates.mat');
%genetic data
%load('pca_snps.mat')
%using new_genetics_snps
%this is result of pca on previous block.  
load('rePCA.mat')
%done in deference to validation directions needing to be related to
%original directions.  steve reccomended doing pca on both datablocks
%together
load('subjectlist.mat')
load("family_removed_subjlist.mat")
load("family_removed_subj_validation.mat")

%fc subject list
key1= subjList;
fc=all_fc';
FC_tab = table(key1,fc);

%sc subject list and initial data
key2 = all_id;
sc=loaded_tensor_sub;
sc1 = cell(1065,1);
for i=1:1065
     sc1{i}=squeeze(loaded_tensor_sub(:,:,1,i));
end

sc_tab = table(key2, sc1);

%cognition and use subject list
key3 = allsubject_id;
fin_trait=cog_measure';
trait_tab = table(key3,fin_trait);

%genetic initial list
key4 = str2double(subjectlist);
%snp_pca = SNPprinp;
%try the first 100 pc's
%snp_pca = snp_pca(:,1:100);

%non related subject list(s) 
%key5 = refined_subject_list;
key5 = validation_subj;

%find the subjects that overlap between datasets
%sharedvals is the actual ID they share.  indx is the index of that ID for
%FC/SC

[sharedvals,indx] = intersect(intersect(key1,key3, 'stable'),key4,'stable');



%this finds the subjects not shared between indices 1:1065 in above line.
%recall that subjects 1066:1206 already kicked out as not having
%connectivity.  these subjects will have seven extraneous sc_fc_rem
%subjects appended to create list of subjects ultimately removed from
%connectivity.  this will aid in back-transform

counter=0;
rem = [];
for i = 1:1065
    if (ismember(i,indx) == 0)
        counter = counter+1;
        rem(counter)=i;
    end
end

%account for the indices taken out originally from sc/fc discrepency 
sc_fc_rem = [1064,870,639,387,351,297,239];
for j=1:7
    rem(counter+j)=sc_fc_rem(j);
end

%now rem is all indices needing to be removed.  first 54 because not shared
%among four types of data and last seven becuase of sc/fc discrepency 

idx=1;
while idx<1066
    if (ismember(idx, rem))
        idx=idx+1;
    else
	%vectorize upper-triangular matrix.  stack these vectors on top of each
    %other.  resulting block will be nxp_k
	    UFC{idx}=triu(fc{idx},1);
        vecFC{idx} = reshape(UFC{idx}.', 1, []);
        fcblock(idx,:)=vecFC{idx};

        sc1{idx}=squeeze(loaded_tensor_sub(:,:,1,idx));
        USC{idx} = log(sc1{idx}+1);
        vecSC{idx} = reshape(USC{idx}.', 1, []);
        scblock(idx,:)=vecSC{idx};
        idx=idx+1;
    end
end

%I am going to wait and remove all non-overlapping subjects at the end.
%once I have created all datablocks
col_indices = rem;

%fcblock(col_indices,:)=[];
%scblock(col_indices,:)=[];


%variance threshold the features
varianceS = zeros(7569,1);
varianceF = zeros(7569,1);
for i = 1:7569
    varianceS(i) = var(scblock(:,i));
    if (varianceS(i)<0.005)
        scblock(:,i)=0;
    end
end

%38 nonzero features removed by this threshold
for i = 1:7569
    varianceF(i) = var(fcblock(:,i));
    if (varianceF(i)<0.005)
        fcblock(:,i)=0;
    end  
end


%a = fcblock(any(fcblock,2),:);
a = fcblock;
%to this point a and fcblock are exactly the same.  now we will transpose
a = a';
%record indices that are zero, so I can go back to original data
row_indices = find(~any(a,2));
a = a(any(a,2),:);


%b = scblock(any(scblock,2),:);
b = scblock;
b = b';
Row_indices = find(~any(b,2));
b = b(any(b,2),:);

rowmeana=zeros(3591,1);
for t=1:3591
    rowmeana(t)=mean(a(t,:));
end

%always check that these indices match up with a to this point.  
objcentera=zeros(3591,1065);
for s=1:1065
    for g=1:3591
        objcentera(g,s)=a(g,s)-rowmeana(g);
    end
end

rowmeanb=zeros(3509,1);
for j=1:3509
    rowmeanb(j)=mean(b(j,:));
end


objcenterb=zeros(3509,1065);
for l=1:1065
    for g=1:3509
        objcenterb(g,l)=b(g,l)-rowmeanb(g);
    end
end

%start including cognition, use. we will work with the full matrix first. 
% but when you reduce, make sure you refer to trait indices not
%FC/SC indices here.  
fin_trait=cog_measure';


C = fin_trait(:,53:88)';
%C above is the raw substance use data
D = fin_trait(:,1:45)';
%D is raw cognition
%E = snp_pca';
E = SNPprinp';
%E = new_genetics';
% E is raw pca's of genetics

%substance use has patterned missing values in variables 16-20, 35.  these,
%interestingly are smoking and marijuana use covariates.  remove these
%before filling other more random missing values

dex = [1:15, 21:34, 36];
C = C(dex, :);

%fill missings with row mean of that missing value
%wrote my own function to do it.  this is in the DIVAS folder now

c = fillMissingValuesWithRowMean(C);
d = fillMissingValuesWithRowMean(D);

%normalize cognition and use
%let's try doing normalization by hand

%this NEEDS to be the normalization done.  Jackstraw is sensitive to it

rowmeanc=zeros(30,1);
for t=1:30
    rowmeanc(t)=mean(c(t,:));
end

rowstdc = zeros(30,1);
for t=1:30
    rowstdc(t)=std(c(t,:));
end
 
normalizec=zeros(30,1206);
for s=1:1206
    for g=1:30
        normalizec(g,s)=(c(g,s)-rowmeanc(g))/rowstdc(g);
    end
end

rowmeand=zeros(45,1);
for t=1:45
    rowmeand(t)=mean(d(t,:));
end

rowstdd = zeros(45,1);
for t=1:45
    rowstdd(t)=std(d(t,:));
end
 
normalized=zeros(45,1206);
for s=1:1206
    for g=1:45
        normalized(g,s)=(d(g,s)-rowmeand(g))/rowstdd(g);
    end
end

%for i=1:36 
    %c(i,:)=normalize(c(i,:));
%end

%for i=1:45
    %d(i,:)=normalize(d(i,:));
%end


%no normalization done since these are just pc's
e = E;

%subset on non-first-order family relations
[sharedvals,indx] = intersect(intersect(intersect(key1,key3, 'stable'),key4,'stable'), key5, 'stable');
%sharedvals are all of the ids that are common between keys.  but the ids
%have different indices across different blocks, so we need to intersect
%with each key individually
%added on june 14 
%blocks c and d shared the same subject list

[~, indxa] = intersect(key1,sharedvals, 'stable');
[~, indxb] = intersect(key2,sharedvals, 'stable');
[~, indxc] = intersect(key3,sharedvals, 'stable');
[~, indxd] = intersect(key3,sharedvals, 'stable');
[~, indxe] = intersect(key4,sharedvals, 'stable');

%can confirm these indices now referrences the 375 (377 for validaiton) non-familially subjects
%shared across all keys

%each block from objcentera to e contains the full slate of subjects.  now
%subset on the correct indices for each block

objcentera = objcentera(:,indxa);
objcenterb = objcenterb(:,indxb);
c = normalizec(:,indxc);
d = normalized(:,indxd);
%changed to make lossless pca
%columns are subjects -- first are indxe (for rerotated genetics, latter 377 are validation indxe)
%rows are loadings directions.
e = e(1:375,376:752);

%FC, SC, Cog, Use, Genetics
fin_dat=[objcentera; objcenterb; d; c; e];
datablock={objcentera; objcenterb; d; c; e};

filterPerc = 0.5;
%now that noiselvls is a part of the paramstruct define it for each datablock
noisepercentile = [0.5, 0.5, 0.5, 0.5, 0.01];


paramstruct = struct('noisepercentile', noisepercentile, 'filterPerc', filterPerc);
out = DJIVEMainJP(datablock, paramstruct) ;
%comment out for cluster
%DJIVEAngleDiagnosticJP(datablock, fin_dat, out, 556, "FC,SC,Cog")

save("may8_valid_run.mat")
