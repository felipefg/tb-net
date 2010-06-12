% load_data.m - Load the data to be used, and divide it into two groups,
% one for training and one for validation, each containing 50% of the
% number of elements on each class.
disp 'Loading data...'

data = load('../data/guadalupe/8v_alcione.txt');

% Remove the target from the variables
target = data(:,end);
data = data(:,1:end-1);

% Class for patients with TB diagnosis
class_positive = data(find(target>0),:);

% Class for patients with non-TB diagnosis
class_negative = data(find(target<0),:);

%% Separate classes into train and test groups
[ class_positive_train, class_positive_validation ] = ...
    dividerand(class_positive', 0.5, 0.5, 0);
[ class_negative_train, class_negative_validation ] = ...
    dividerand(class_negative', 0.5, 0.5, 0);

train =      { class_positive_train     , class_negative_train };
validation = { class_positive_validation, class_negative_validation };

%% Save results to freeze the random selection of groups
save train_validation_data train validation

%% Clean up
clear data target
clear class_positive class_positive_train class_positive_validation
clear class_negative class_negative_train class_negative_validation