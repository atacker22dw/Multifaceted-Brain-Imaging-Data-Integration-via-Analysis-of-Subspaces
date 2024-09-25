%R^2 Decomp
%FC

indFC = out.matBlocks{1}('1');
FC_SC = out.matBlocks{1}('3');
FC_Cog = out.matBlocks{1}('5');
FC_Use = out.matBlocks{1}('9');
FC_Gene = out.matBlocks{1}('17');
FC_SC_Use = out.matBlocks{1}('11');

ss_FC = norm(indFC,'fro')^2;
ss_FC_SC = norm(FC_SC,'fro')^2;
ss_FC_Cog = norm(FC_Cog,'fro')^2;
ss_FC_Use = norm(FC_Use, 'fro')^2;
ss_FC_Gene = norm(FC_Gene, 'fro')^2;
ss_FC_SC_Use = norm(FC_SC_Use, 'fro')^2;
sstot = ss_FC+ss_FC_SC+ss_FC_Cog+ss_FC_Use+ss_FC_Gene+ss_FC_SC_Use;

r_ind = ss_FC/sstot
r_FC_SC = ss_FC_SC/sstot
r_FC_Cog = ss_FC_Cog/sstot
r_FC_Use = ss_FC_Use/sstot
r_FC_Gene = ss_FC_Gene/sstot
r_FC_SC_Use = ss_FC_SC_Use/sstot

%SC
indSC = out.matBlocks{2}('2');
SC_FC = out.matBlocks{2}('3');
SC_Cog = out.matBlocks{2}('6');
SC_Use = out.matBlocks{2}('10');
SC_Gene = out.matBlocks{2}('18');
SC_FC_Use = out.matBlocks{2}('11');

ss_SC = norm(indSC,'fro')^2;
ss_SC_FC = norm(SC_FC,'fro')^2;
ss_SC_Cog = norm(SC_Cog,'fro')^2;
ss_SC_Use = norm(SC_Use,'fro')^2;
ss_SC_Gene = norm(SC_Gene,'fro')^2;
ss_SC_FC_Use = norm(SC_FC_Use, 'fro')^2;
sstot2 = ss_SC+ss_SC_FC+ss_SC_Cog+ss_SC_Use+ss_SC_Gene+ss_SC_FC_Use;

r_SC = ss_SC/sstot2
r_SC_FC = ss_SC_FC/sstot2
r_SC_Cog = ss_SC_Cog/sstot2
r_SC_Use = ss_SC_Use/sstot2
r_SC_Gene = ss_SC_Gene/sstot2
r_SC_FC_Use = ss_SC_FC_Use/sstot2

%cog
cog_FC = out.matBlocks{3}('5');
cog_SC = out.matBlocks{3}('6');
cog_use = out.matBlocks{3}('12');

ss_cog_FC = norm(cog_FC,'fro')^2;
ss_cog_SC = norm(cog_SC,'fro')^2;
ss_cog_use = norm(cog_use,'fro')^2;
sstot3 = ss_cog_FC+ss_cog_SC+ss_cog_use;

r_cog_FC = ss_cog_FC/sstot3
r_cog_SC = ss_cog_SC/sstot3
r_cog_use = ss_cog_use/sstot3

%use 
use_FC_SC = out.matBlocks{4}('11');
use_FC = out.matBlocks{4}('9');
use_SC = out.matBlocks{4}('10');
use_cog = out.matBlocks{4}('12');

ss_use_FC = norm(use_FC,'fro')^2;
ss_use_SC = norm(use_SC,'fro')^2;
ss_use_cog = norm(use_cog,'fro')^2;
ss_use_FC_SC = norm(use_FC_SC, 'fro')^2;
sstot4 = ss_use_FC+ss_use_SC+ss_use_cog+ss_use_FC_SC;

r_use_FC = ss_use_FC/sstot4
r_use_SC = ss_use_SC/sstot4
r_use_cog = ss_use_cog/sstot4
r_use_FC_SC = ss_use_FC_SC/sstot4

%gene
Gene_FC = out.matBlocks{5}('17');
Gene_SC = out.matBlocks{5}('18');
indGene = out.matBlocks{5}('16');

ss_Gene_FC = norm(Gene_FC,'fro')^2;
ss_Gene_SC = norm(Gene_SC,'fro')^2;
ss_Gene = norm(indGene, 'fro')^2;
sstot5 = ss_Gene_FC+ss_Gene_SC+ss_Gene;

r_gene_FC = ss_Gene_FC/sstot5
r_gene_SC = ss_Gene_SC/sstot5
r_gene = ss_Gene/sstot5
