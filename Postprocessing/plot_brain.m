%code adapted from Zhengwu.
%referrences functions in circularGraph folder

%this will do a circular plot for SC Rank 1 Loadings
%then circular plot for FC Rank 1 Loadings

%sister function is brain_circplot.m, but that plots log transforms of this
%data

%circle plot
clear all;
close all;

addpath(genpath('circularGraph'))

%get the indices to from DIVAS Jackstraw

%for FC
keepElements = false(size(Loads_corre{1}));
keepElements(INDICES) = true;
Loads_corre{1}(~keepElements) = 0;

%we want to plot circles;
%prepare for the circle plot;
%reorgnize the nodes;


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
    
    brain_net = Loads_corre{1};
   
    %smallest and biggest value in this brain network.
    low_bound = min(min(brain_net));
    up_bound = max(max(brain_net));
    
    figure(5); set(gcf, 'Position', [100 100 540 500]);clf;
    circularGraph_dynamicnetwork(brain_net(final_index,final_index),'Label',myLabel,'EdgeColorMapRange',[low_bound,up_bound]);
    % circularGraph_dynamicnetwork(brain_net_thrd(final_index,final_index),'Label',myLabel,'EdgeColorMapRange',[low_bound,up_bound]);
    colorbar;
    
    
    
    %let's try something similar with SC


keepElements_SC = false(size(LOADs{1}));
keepElements_SC(indices) = true;
LOADs{1}(~keepElements_SC) = 0;

brain_net = LOADs{1};
   
 %smallest and biggest value in this brain network.
 low_bound = min(min(brain_net));
 up_bound = max(max(brain_net));
    
 
 figure(5);set(gcf, 'Position', [100 100 540 500]);clf;
 circularGraph_dynamicnetwork(brain_net(final_index,final_index),'Label',myLabel,'EdgeColorMapRange',[low_bound,up_bound]);
 colorbar;
 
 %ensure this matches non-negative connections of thresholded adjacency
 HeatmapVisualJP(brain_net_thrd, "Thresholded Adjacency Matrix")
 caxis([-0.06, 0.06])
 nnz(brain_net_thrd)
 
 
 
 
 
 
    