function [f]=MIS(p)

i=p;

[s1 s2 s3]=size(i);








Xc1=p;



%DMD

[Phi1 ,omega1 ,lambda1 ,b1,Xdmd1]=DMD(Xc1(:,1:end-1),Xc1(:,2:end),10,0.001);


%seperating law rank (X1L, X2L) and sparse matrices(X1L,X2L)

X1L=[Phi1(:,1) Phi1(:,6:end)];
X1S=Phi1(:,2:5);


%normalizing the low rank and sparse matrices
X1SN=(X1S-min(X1S))/(max(X1S)-min(X1S));
X1LN=(X1L-min(X1L))/(max(X1L)-min(X1L));


%colour based saliency map
SM1=((X1SN)-0.5*(X1LN));
%SM1=(X1S);
%reshaping the image from mnx1 column vector to the ordinal image dimention mxn 
f=SM1;





end
