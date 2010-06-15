function [ trn, val, tst, norm_info ] = normalize_tb(trn, val, tst, norm_info)
% NORMALIZE_TB Normalize the TB data

%% Calculate the parameters, if needed
if ~ isfield(norm_info, 'centers'),
    train_data = [ trn{1} trn{2} ];

    norm_info.centers = zeros(size(train_data, 1), 1);
    norm_info.factors =  ones(size(train_data, 1), 1);

    norm_info.centers(1,1) = mean(train_data(1,:));
    norm_info.factors(1,1) = 1.0/max(abs(train_data(1,:) - norm_info.centers(1,1)));
end

% Apply the normalization
trn = apply_normalization(trn, norm_info.centers, norm_info.factors);
val = apply_normalization(val, norm_info.centers, norm_info.factors);
tst = apply_normalization(tst, norm_info.centers, norm_info.factors);

end

function [ data ] = apply_normalization(data, centers, factors)

for i=1:size(data, 2),
    data{i} = data{i} -  repmat(centers, 1, size(data{i}, 2));
    data{i} = data{i} .* repmat(factors, 1, size(data{i}, 2));
end

end
