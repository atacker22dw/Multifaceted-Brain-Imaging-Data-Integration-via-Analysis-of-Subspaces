
%run as part of invert_vectorize.m
%rank 1 space

D = 1;
k = 1;
nran = 1;
nsim = 15000;
ti = 0.05;


Y = objcentera;
x_1 = out.jointBasisMap('11');
x_2 = out.jointBasisMap('3');
x_3 = out.jointBasisMap('6');
x_4 = out.jointBasisMap('9');
x_5 = out.jointBasisMap('17');
x_6 = out.jointBasisMap('1');

x = [x_1 x_2 x_3 x_4 x_5 x_6];
%so first direction corresponds to rank 1 three space
%directions 2-28 correspond to pairwise fc-sc space
x = x';
[F_feature, F_n, P] = DIVAS_jackstraw(Y,x,k,D, nran, nsim, ti);
find(P<0.05/3591)



Y = objcenterb;

x_1 = out.jointBasisMap('11');
x_2 = out.jointBasisMap('3');
x_3 = out.jointBasisMap('6');
x_4 = out.jointBasisMap('10');
x_5 = out.jointBasisMap('18');
x_6 = out.jointBasisMap('2');

x = [x_1 x_2 x_3 x_4 x_5 x_6];
x = x';
[F_feature, F_n, P] = DIVAS_jackstraw(Y,x,k,D, nran, nsim, ti);
find(P<0.05/3509)

Y = c;
x_1 = out.jointBasisMap('11');
x_2 = out.jointBasisMap('9');
x_3 = out.jointBasisMap('10');
x_4 = out.jointBasisMap('12');

x = [x_1 x_2 x_3 x_4];
x = x';

[F_feature, F_n, P] = DIVAS_jackstraw(Y,x,k,D, nran, nsim, ti);
find(P<0.05/30)




