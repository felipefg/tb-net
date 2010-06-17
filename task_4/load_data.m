% load_data.m - Load the data to be used, and divide it into two groups,
% one for training and one for validation, each containing 50% of the
% number of elements on each class.
disp 'Loading data...'

if ~exist('datafile', 'var'),
    datafile = '10v.txt';
end
data = load(sprintf('../data/guadalupe/%s', datafile));

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

%% Normalize data for the 8 variables
centers = zeros(size(data, 2), 1);
factors =  ones(size(data, 2), 1);

all_train = [train{1} train{2}];
centers(1,1) = mean(all_train(1,:));
factors(1,1) = 1.0/max(abs(all_train(1,:) - centers(1,1)));

% Apply the normalization
for i=1:2,
    train{i} = train{i} -  repmat(centers, 1, size(train{i}, 2));
    train{i} = train{i} .* repmat(factors, 1, size(train{i}, 2));

    validation{i} = validation{i} -  repmat(centers, 1, size(validation{i}, 2));
    validation{i} = validation{i} .* repmat(factors, 1, size(validation{i}, 2));
end

%% Clean up
clear data target all_train i
clear class_positive class_positive_train class_positive_validation
clear class_negative class_negative_train class_negative_validation
