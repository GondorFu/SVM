% 1.Load the sample data, which includes Fisher's iris data of 5 measurements on a sample of 150 irises.

load fisheriris

% 2.Create data, a two-column matrix containing sepal length and sepal width measurements for 150 irises.

data = [meas(:,1), meas(:,2)];

% 3.From the species vector, create a new column vector, groups, to classify data into two groups: Setosa and non-Setosa.

groups = ismember(species,'setosa');

% 4.Randomly select training and test sets.

[train, test] = crossvalind('holdOut',groups);
cp = classperf(groups);

% 5.Use the svmtrain function to train an SVM classifier using a linear kernel function and plot the grouped data.

svmStruct = svmtrain(data(train,:),groups(train),'showplot',true);

% 6.Add a title to the plot, using the KernelFunction field from the svmStruct structure as the title.

title(sprintf('Kernel Function: %s',...
    func2str(svmStruct.KernelFunction)),...
    'interpreter','none');

% 7.Classify the test set using a support vector machine.

classes = svmclassify(svmStruct,data(test,:),'showplot',true);

% 8.Evaluate the performance of the classifier.

classperf(cp,classes,test);
cp.CorrectRate

% ans = 0.9867

% 9.Use a one-norm, hard margin support vector machine classifier by changing the boxconstraint property.

figure
svmStruct = svmtrain(data(train,:),groups(train),...
    'showplot',true,'boxconstraint',1e6);

classes = svmclassify(svmStruct,data(test,:),'showplot',true);

% 10.Evaluate the performance of the classifier.

classperf(cp,classes,test);
cp.CorrectRate

% ans = 0.9867