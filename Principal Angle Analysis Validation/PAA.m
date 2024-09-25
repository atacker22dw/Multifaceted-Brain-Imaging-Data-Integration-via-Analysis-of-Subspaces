%Principal Angle Validation 

%read in original output

FC_inCog = out.matLoadings{1}('5');
Cog_inFC = out.matLoadings{3}('5');
FC_inUse = out.matLoadings{1}('9');
Use_inFC = out.matLoadings{4}('9');
FC_inSC = out.matLoadings{1}('3');
SC_inFC = out.matLoadings{2}('3');
FC_inGene = out.matLoadings{1}('17');
Gene_inFC = out.matLoadings{5}('17');
SC_inGene = out.matLoadings{2}('18');
Gene_inSC = out.matLoadings{5}('18');
SC_inCog = out.matLoadings{2}('6');
Cog_inSC = out.matLoadings{3}('6');
SC_inUse = out.matLoadings{2}('10');
Use_inSC = out.matLoadings{4}('10');
Cog_inUse = out.matLoadings{3}('12');
Use_inCog = out.matLoadings{4}('12');

FC = out.matLoadings{1}('1');
SC = out.matLoadings{2}('2');
Gene = out.matLoadings{5}('16');

%in a non-shared space 
FC_inSC_Use = out.matLoadings{1}('11');
SC_inFC_Use = out.matLoadings{2}('11');


%read in valid output
FC_inCog_valid = out.matLoadings{1}('5');
Cog_inFC_valid = out.matLoadings{3}('5');
FC_inUse_valid = out.matLoadings{1}('9');
Use_inFC_valid = out.matLoadings{4}('9');
FC_inSC_valid = out.matLoadings{1}('3');
SC_inFC_valid = out.matLoadings{2}('3');
FC_inGene_valid = out.matLoadings{1}('17');
Gene_inFC_valid = out.matLoadings{5}('17');
SC_inGene_valid = out.matLoadings{2}('18');
Gene_inSC_valid = out.matLoadings{5}('18');
SC_inCog_valid = out.matLoadings{2}('6');
Cog_inSC_valid = out.matLoadings{3}('6');
SC_inUse_valid = out.matLoadings{2}('10');
Use_inSC_valid = out.matLoadings{4}('10');
Cog_inUse_valid = out.matLoadings{3}('12');
Use_inCog_valid = out.matLoadings{4}('12');

FC_valid = out.matLoadings{1}('1');
SC_valid = out.matLoadings{2}('2');
Gene_valid = out.matLoadings{5}('16');

%in a non-shared space 
FC_inSC_cog = out.matLoadings{1}('7');
SC_inFC_cog = out.matLoadings{2}('7');

%use mPrinAngles.m 

rad2deg(mPrinAngles(FC_inSC, FC_inSC_valid))
rad2deg(mPrinAngles(SC_inFC, SC_inFC_valid))

rad2deg(mPrinAngles(FC_inGene, FC_inGene_valid))
rad2deg(mPrinAngles(Gene_inFC, Gene_inFC_valid))

rad2deg(mPrinAngles(SC_inGene, SC_inGene_valid))
rad2deg(mPrinAngles(Gene_inSC, Gene_inSC_valid))

rad2deg(mPrinAngles(FC_inCog, FC_inCog_valid))
rad2deg(mPrinAngles(Cog_inFC, Cog_inFC_valid))

rad2deg(mPrinAngles(FC_inUse, FC_inUse_valid))
rad2deg(mPrinAngles(Use_inFC, Use_inFC_valid))

rad2deg(mPrinAngles(Cog_inUse, Cog_inUse_valid))
rad2deg(mPrinAngles(Use_inCog, Use_inCog_valid))

rad2deg(mPrinAngles(SC_inUse, SC_inUse_valid))
rad2deg(mPrinAngles(Use_inSC, Use_inSC_valid))

rad2deg(mPrinAngles(SC_inCog, SC_inCog_valid))
rad2deg(mPrinAngles(Cog_inSC, Cog_inSC_valid))

rad2deg(mPrinAngles(FC,FC_valid))
rad2deg(mPrinAngles(SC,SC_valid))
rad2deg(mPrinAngles(Gene,Gene_valid))