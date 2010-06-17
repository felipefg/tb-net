function plot_difference_global_n_epochs(trs, n_epochs)

hold on;

for i=1:length(trs),
    
    SPs = reshape(trs{i}.sp_val, n_epochs, length(trs{i}.sp_val)/n_epochs);
    
    SP_max = max(trs{i}.sp_val);
    
    maxs = max(SPs);
    
    rel_dif = (SP_max - maxs)/SP_max;
    
    X = 1:n_epochs:length(trs{i}.sp_val);
    plot(X, rel_dif);

end

xlabel('Epocas');
ylabel('Diferenca relativa');
title(sprintf('Diferenca relativa entre SP maximo SP no bloco de %d epocas e maximo global', n_epochs));
grid();