% gen_plots.m - Generate the plots (using matplotlib for better results).

%% Find the files that will be visited
files = {};
dir_list = dir();
for i=1:length(dir_list),

    filename = dir_list(i).name;

    if findstr('mat', filename),
        if findstr('results_', filename),
            files{end+1} = filename;
        end
    end

end

%% Regroup data into an easy structure
results = struct();

for i=1:length(files),

    data = load(files{i});

    for k=1:length(data.files),
        % Remove leading and trailing parts of the file name
        filename = data.files{k}(19:end-4);
        key = sprintf('data_%s', filename);

        % Initialize a new file if needed
        if ~isfield(results, key),
            results.(key) = struct();
            results.(key).neurons = zeros(1, length(files));
            results.(key).sp_mean = zeros(1, length(files));
            results.(key).sp_std  = zeros(1, length(files));
            results.(key).tr      =  cell(1, length(files));
        end

        % Fill in statistics
        results.(key).neurons(i) = data.neurons;
        results.(key).sp_mean(i) = mean(data.rets{k}.sp);
        results.(key).sp_std(i)  =  std(data.rets{k}.sp);
        results.(key).sp_max(i)  =  max(data.rets{k}.sp);
        results.(key).tr{i} = data.rets{k}.evo; 
    end
end

%% Plot data
fields = fieldnames(results);

figure;
hold on;
colors = {'b', 'r', 'k'};

for i=1:length(fields),
    key = fields{i};

    ToPlot = [results.(key).neurons; results.(key).sp_mean; results.(key).sp_std; results.(key).sp_max];

    [neurons, order] = sortrows(results.(key).neurons');

    errorbar(neurons, ...
             results.(key).sp_mean(order), ...
             results.(key).sp_std(order), ...
             'Color', colors{i}, 'DisplayName', key(6:end));
         
    object_handle = plot(neurons, ...
                         results.(key).sp_max(order), ...
                         'x', 'Color', colors{i});

    % A little magic to hide this plot from the legend
    hAnnotation = get(object_handle,'Annotation');
    hLegendEntry = get(hAnnotation','LegendInformation');
    set(hLegendEntry,'IconDisplayStyle','off')

    
end
grid on;
xlabel('Neuronios na camada escondida');
ylabel('Produto SP');
title(key(6:end));
legend('Location', 'SouthEast');

%{
%% Plot convergence data
neurons = results.(key).neurons;
for i=1:length(neurons),
    
    figure;
    
    for j=1:length(fields),
        key = fields{j};
        
        subplot(2, 3, j)
        plot_difference_global_n_epochs(results.(key).tr{i}, 100);
        title(sprintf('Diferenca para SP global para %s com %d neuronios', key, neurons(i)));
        
        subplot(2, 3, j+3)
        plot_difference_n_epochs(results.(key).tr{i}, 100);
    end
    
    %print(gcf, '-dpng', sprintf('%s-%d.png',key, neurons(i)));
    %close;
end
%}
