function plot_difference_n_epochs(trs, n_epochs)

hold on;

for i=1:length(trs),
    
    SPs = reshape(trs{i}.sp_val, n_epochs, length(trs{i}.sp_val)/n_epochs);
    
    min_max = minmax(SPs');
    
    rel_dif = (min_max(:,2) - min_max(:,1))/(min_max(:,2));
    
    
    X = 1:n_epochs:length(trs{i}.sp_val);
    plot(X, rel_dif);

end

xlabel('Epocas');
ylabel('Diferenca relativa entre minimo e maximo');
title(sprintf('Diferenca relativa entre minimo e maximo SP a cada %d epocas', n_epochs));
grid();