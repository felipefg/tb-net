% gen_roc_plots: generate the ROC plots

if ~ exist('results', 'var'),
    load for_python;
end

load roc_joao;

fa_08v  = mean(results.data_10v.fa);
det_08v = mean(results.data_10v.det);

fa_10v  = mean(results.data_8v_alcione.fa);
det_10v = mean(results.data_8v_alcione.det);

fa_12v  = mean(results.data_guadalupe.fa);
det_12v = mean(results.data_guadalupe.det);

fa_alc  = redeJoao.fa;
det_alc = redeJoao.det;

figure;
hold on;
plot(fa_08v, det_08v, 'Color', [1 0 0], 'DisplayName', '8 variaveis');
plot(fa_10v, det_10v, 'Color', [0 0 1], 'DisplayName', '10 variaveis');
plot(fa_12v, det_12v, 'Color', [0 0.749019622802734 0.749019622802734], 'DisplayName', '12 variaveis');
plot(fa_alc, det_alc, 'Color', [0 0 0], 'DisplayName', 'Rede da Alcione');

xlabel('1 - Especificidade');
ylabel('Sensibilidade');
legend('Location', 'SouthEast');
grid on;

print(gcf, '-dpng', 'roc_4redes.png');
saveas(gcf, 'roc_4redes.fig', 'fig');

% Zoom!
xlim([0.0910138248847926 0.362903225806452]);
ylim([0.621345029239766 0.884502923976608]);

print(gcf, '-dpng', 'roc_4redes_zoom.png');
saveas(gcf, 'roc_4redes_zoom.fig', 'fig');
