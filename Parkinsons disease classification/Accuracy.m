function Accuracy = Accuracy(data)
w = warning ('off','all');
data=[shuffle(data(:,1:24),2) shuffle(data(:,25:49),2)];
data_train=[data(:,1:18) data(:,25:42)];
data_test=[data(:,19:24) data(:,43:49)];


%ANN

% generate an input
X = data_train(1:end-1,:);
% generate an output
Y = data_train(end,:);

% generate an input
X_test = data_test(1:end-1,:);
% generate an output
Y_test = data_test(end,:);

%knn

Mdl_knn = fitcknn(X',Y','NumNeighbors',4,'Standardize',1);

flwrClass = predict(Mdl_knn,X_test');

A1=sum(flwrClass==Y_test')/13;



%Logistic regression
mdl_LR = fitglm(X',Y');

I1=predict(mdl_LR,X_test');

A2=sum((floor(I1)==Y_test'))/13;


% The column vector, species, consists of iris flowers of three different species, setosa, versicolor, virginica. The double matrix meas consists of four types of measurements on the flowers, the length and width of sepals and petals in centimeters, respectively.
% Define the nominal response variable using a categorical array.
sp = categorical(Y');
% Fit a multinomial regression model to predict the species using the measurements.  
[B,dev,stats] = mnrfit(X',Y');
%sum(B*X);

[M I]=max(mnrval(B,X_test')');

A3=sum(I==Y_test)/13;


%Descision-Tree
Mdl_DT = fitctree(X',Y');
I2=predict(Mdl_DT,X_test');
A4=sum(I2==Y_test')/13;

%SVM
ivl=[1:18 37:34];
ivl_test=[1:7 14:18];
Mdl_svm = fitcsvm(X(:,:)',Y(:,:)','KernelFunction','rbf');

I3=predict(Mdl_svm,X_test(:,:)');
Y(:,ivl)';
A5=sum(I3==Y_test(:,:)')/13;

%BAGGING

%load fisheriris
%X = meas;
%Y = species;

rng();

Mdl = TreeBagger(50,X',Y',...
    Method="classification",...
    OOBPrediction="on");


I4=cell2mat(predict(Mdl,X_test'));

A6=sum(I4==int2str(Y_test'))/13;


w = warning ('on','all');

%XG-Boost

Accuracy=[A1;A2;A3;A4;A5;A6];



end