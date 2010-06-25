function [ data ] = load_data(filename)
% LOAD_DATA - Loads the data in the given file and returns a cell array
% with the data divided into classes.

data = load(filename);

% Remove the target from the variables
target = data(:,end);
data = data(:,1:end-1);

% Class for patients with TB diagnosis
class_positive = data(find(target>0),:).';

% Class for patients with non-TB diagnosis
class_negative = data(find(target<0),:).';

data = { class_positive, class_negative };

end
