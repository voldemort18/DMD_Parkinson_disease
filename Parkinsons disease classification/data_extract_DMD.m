function matrix=data_extract_DMD(a1,g)

path=append(a1.folder,'\',a1.name);

a=load(path);
b=a.EEG.data;

d=b(g,:,:);
[n1 n2 n3]=size(d);
k=reshape(d,[n2,n3,n1]);
%k=mean(k,3)

SM1=MIS(k);


l1=a;


var=varm(2,2);

%[im2double(k(:,1)) L1(:,1)]
SM1=im2double(SM1);


mod=estimate(var,[im2double(k(:,1)) SM1(:,1)]);
z=[cell2mat(mod.AR) mod.Constant];

x=real(pca(z'));
matrix=x(:,1);
end