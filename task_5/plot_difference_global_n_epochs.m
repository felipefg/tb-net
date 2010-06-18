function plot_difference_global_n_epochs(trs, n_epochs, xmax)

hold on;

for i=1:length(trs),

    SP_max = max(trs{i}.sp_val);

    X = 1:n_epochs:length(trs{i}.sp_val);

    for j=1:length(X),
        maxs(j) = max(trs{i}.sp_val(1:X(j)));
    end

    rel_dif = (SP_max - maxs)/SP_max;

    plot(X, rel_dif);

end

xlabel('Epocas');
ylabel('Diferenca relativa');
title(sprintf('Diferenca relativa entre SP maximo SP no bloco de %d epocas e maximo global', n_epochs));
grid();

if nargin == 3,
    xlim([1 xmax]);
end
