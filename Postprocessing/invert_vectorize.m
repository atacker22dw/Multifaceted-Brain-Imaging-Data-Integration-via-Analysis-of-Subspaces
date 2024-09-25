
clear all;
close all;

%load may7_orig_run.mat
%FC

%run jackstraw to get a mask of the significant features
%preprocessing_jackstraw.m script
 
%mask on significant features
sub_ind = P <= 1.3924e-05;
%invert FC loadings in SC_Use Space
onedim = out.matLoadings{1}('11');
index_mask = false(size(onedim));
index_mask(sub_ind) = true;
onedim(~index_mask) = 0;


onedim=onedim';
%make vector norm 1one
onedim = onedim/norm(onedim);

vecLf= zeros(1,7569);
num_zero = 0;

for j = 1:7569
   if ismember(j,row_indices) == 1
      vecLf(1,j)=0;
      num_zero = num_zero+1;
   else
      vecLf(1,j)=onedim(1,j-num_zero);
   end 
end
uload = cell(1, 1);
LOADf = cell(1, 1);

uload{1}=reshape(vecLf(1,:),[87,87]);
LOADf{1}=uload{1}+uload{1}';

%create correspondance between SC and FC
Loads_corre=cell(1,1);
%read in this data from presentation 12 folder
correspond = csvread("correspondance.csv");

for x = 1:87 
    for y = 1:87
        %puts FC in SC order
        Loads_corre{1}(x,y)=LOADf{1}(correspond(x),correspond(y));
    end
end

%imagesc(Loads_corre{1})
%HeatmapVisualJP(Loads_corre{1}, "Back Transformed (Norm 1) Object-Centered FC Loadings")

%similarly for sc, 
%run jackstraw

sub_ind = P <= 1.4249e-05;
%invert FC loadings in SC_Use Space
onedimSC = out.matLoadings{2}('11');
index_mask = false(size(onedimSC));
index_mask(sub_ind) = true;
onedimSC(~index_mask) = 0;

onedimSC=onedimSC';
%makes vectors norm 1
onedimSC = onedimSC/norm(onedimSC);

%this will be a vector of same length as a vectorized 87x87 matrix
vecLs= zeros(1,7569);
num_zero = 0;

for j = 1:7569
   if ismember(j,Row_indices) == 1
      %if index is a Row_indice, this element is a zero
      vecLs(1,j)=0;
      num_zero = num_zero+1;
   else
      vecLs(1,j)=onedimSC(1,j-num_zero);
   end 
end

%vecLs is now the length 7569 vector with zeros in the correct indices
%ready to be "unvectorized" into an adjacency matrix
uloads = cell(1, 1);
LOADs = cell(1, 1);

uloads{1}=reshape(vecLs(1,:),[87,87]);
LOADs{1}=uloads{1}+uloads{1}';

% create an adjacency matrix that is part SC and part FC
upperTriangularIndices = triu(true(87, 87), 1);
% Zero out the upper triangular part
LOADs{1}(upperTriangularIndices) = 0;

lowerTriangularIndices = tril(true(87, 87), -1);

% Zero out the lower triangular part
Loads_corre{1}(lowerTriangularIndices) = 0;

final_loads = Loads_corre{1}+LOADs{1};
HeatmapVisualJP(final_loads, "Back Transformed (Norm 1) FC Loadings (Upper Triangular) and SC Loadings (Lower Triangular)")

%go straight to circle plot


rfl = [65, 61, 60, 57, 53, 52, 51, 50, 47, 45, 37];
rsu = [68];
rlc = [59, 56, 49, 43, 36];
rpl = [64, 62, 58, 55, 41];
rtl = [67, 66, 63, 48, 42, 40, 39, 35];
rol = [54, 46, 44, 38];

lfl = [3, 11, 13, 16, 17, 18, 19, 23, 26, 27, 31];
lsu = [34];
llc = [2, 9, 15, 22, 25];
lpl = [7, 21, 24, 28, 30];
ltl = [1, 5, 6, 8, 14, 29, 32, 33];
lol = [4, 10, 12, 20];


col_index = [lfl,lsu,llc,lpl,ltl,lol,rfl,rsu,rlc,rpl,rtl,rol]+19;
left_index=[lfl,lsu,llc,lpl,ltl,lol]+19;
right_index=[rol,rtl,rpl,rlc,rsu,rfl]+19;
whole_index=1:87;
subcortical=[1:9,19,18,17,16,15,14,13,12,11,10];
final_index=[left_index,subcortical,right_index];


Nnode = length(final_index);
%plot circle
myLabel = cell(Nnode);
for i = 1:Nnode
    if(i<11.5)
        if(i==1)
            myLabel{i} = sprintf('l-FL-%d',final_index(i)-19); %frontal lobe
        else
            myLabel{i} = sprintf('%d',final_index(i)-19);
        end
    elseif(i<12.5)
        if(i==12)
            myLabel{i} = sprintf('l-SU-%d',final_index(i)-19);
        else
            myLabel{i} = sprintf('%d',final_index(i)-19);
        end
        
    elseif(i<17.5)
        if(i==13)
            myLabel{i} = sprintf('l-LC-%d',final_index(i)-19); % limbic lobe cortex
        else
            myLabel{i} = sprintf('%d',final_index(i)-19);
        end
        
    elseif(i<22.5)
        if(i==18)
            myLabel{i} = sprintf('l-PL-%d',final_index(i)-19); %parietal lobe
        else
            myLabel{i} = sprintf('%d',final_index(i)-19);
        end
        
    elseif(i<30.5)
        if(i==23)
            myLabel{i} = sprintf('l-TL-%d',final_index(i)-19); %Temporal lobe
        else
            myLabel{i} = sprintf('%d',final_index(i)-19);
        end
        
    elseif(i<34.5)
        if(i==31)
            myLabel{i} = sprintf('l-OL-%d',final_index(i)-19); %Occipital lobe
        else
            myLabel{i} = sprintf('%d',final_index(i)-19);
        end
        
    elseif(i<53.5)
        if(i==35)
            myLabel{i}=sprintf('Subcort-%d',final_index(i));
        elseif(i==53)
            myLabel{i}=sprintf('%d-Subcort',final_index(i));
        else
            myLabel{i} = sprintf('%d',final_index(i));
        end
                
    elseif(i<57.5)
        if(i==57)
            myLabel{i} = sprintf('%d-OL-r',final_index(i)-34-19);
        else
            myLabel{i} = sprintf('%d',final_index(i)-34-19);
        end
    elseif(i<65.5)
        if(i==65)
            myLabel{i} = sprintf('%d-TL-r',final_index(i)-34-19);
        else
            myLabel{i} = sprintf('%d',final_index(i)-34-19);
        end
        
    elseif(i<70.5)
        if(i==70)
            myLabel{i} = sprintf('%d-PL-r',final_index(i)-34-19);
        else
            myLabel{i} = sprintf('%d',final_index(i)-34-19);
        end
        
    elseif(i<75.5)
        if(i==75)
            myLabel{i} = sprintf('%d-LC-r',final_index(i)-34-19);
        else
            myLabel{i} = sprintf('%d',final_index(i)-34-19);
        end
        
    elseif(i<76.5)
        if(i==76)
            myLabel{i} = sprintf('%d-SU-r',final_index(i)-34-19);
        else
            myLabel{i} = sprintf('%d',final_index(i)-34-19);
        end
        
    elseif(i<87.5)
        if(i==87)
            myLabel{i} = sprintf('%d-FL-r',final_index(i)-34-19);
        else
            myLabel{i} = sprintf('%d',final_index(i)-34-19);
        end
    end
end
    %plot fc
    brain_net = Loads_corre{1};

    low_bound = min(min(brain_net));
    up_bound = max(max(brain_net));

    %source circularGraph
    figure(5); set(gcf, 'Position', [100 100 540 500]);clf;
    circularGraph_dynamicnetwork(brain_net(final_index,final_index),'Label',myLabel,'EdgeColorMapRange',[low_bound,up_bound]);
    colorbar;
    caxis([-0.3, 0.3])

    %plot SC
    
    brain_net = LOADs{1};
   
    low_bound = min(min(brain_net));
    up_bound = max(max(brain_net));
 
    figure(5); set(gcf, 'Position', [100 100 540 500]);clf;
    circularGraph_dynamicnetwork(brain_net(final_index,final_index),'Label',myLabel,'EdgeColorMapRange',[low_bound,up_bound]);
    colorbar;
    caxis([-0.3, 0.3])




